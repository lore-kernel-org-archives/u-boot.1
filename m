Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAB1CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC93880E09;
	Mon, 28 Sep 2026 17:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7-KNfcnsWe9m; Mon, 28 Sep 2026 17:05:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 429CE80E9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615105;
	b=tHEIWQyviyJ+zn8NJijORSWX4YIHQcWScHRwJxSG/3FaMkXLWcns2VP8oWS8KO3AX0XT
	 o6gYY39Dih+bd4bL2JicUJs+JHZyYePCAtYTtyzHWjxIqQ5UbV6evBPw5pFEV7Yl/zZiQ
	 2Fm4wJcNiAo/Km087UggWMjkZyDWBCMRu5oWyySP1l2AAEOtynMBepLQ59ZHGKzhQta/3
	 7w8SpbY2jM+NFzvIyETCEWgaiA9djKmm/XtuPKMhE0rjASbJ6Zt26qaDmFpmFg66pXhfJ
	 snJZ6eYRkFDzFCp0VY7Y2M+Sog5nIVSx1DwRRGP51XZ9AVDpqOduabW/16VjzXQa65Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JRCPVijiQDHCMC1R39Xvr713c3c+OBou2Svnurdf2hY=;
	b=bAlUs37ny7nNkqHUGBDj7sHOe2XyLwki184GkqKp3V+W3hyaoiSZ/BE2oprCCS0T6QDt
	 aB+aonf1eFadLI00gTbEskaWAHNX6zLpw02jWoFOIUsxKwSYCpQPcPWO/q3AD+iVJxokl
	 TU3/vq/3SjZzV7orcvPj1edrEWKIZlAzfTWSBJKg0ac5d9MtS/E9mdHhOLBOfhMpBEuzT
	 kUY7kPAPsH86QG442Y7BBeMWGunP8kPpPvIhNyFM8dtIcWrmw2b4RYQvhyIeQD70j0AXS
	 423FQOaycHVNsqCo2ybgxmp4IMfFmN5qCI8blXKzD/hY0xjAQsBFJn9DF3/w3kpLVFw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615105;
	bh=JRCPVijiQDHCMC1R39Xvr713c3c+OBou2Svnurdf2hY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0/MlHi9LpDShFmNhwAztNgHVhKDpG1L/8fF5XPlEddN5nFKUx9NubIkGiqCWO0qcI
	 xg3WGDdfcx+pjPhQbSCgMlBsH93eAOKJdJD78TEK+two4CN7LN/iUpPVCv+ZlxWLqj
	 2xv3Jt1ra6JQvI0jAiEnau4Vsa4+LfaFqaeUfyUiA6UU4ZASdhiR7W7zTpCi4l3dOD
	 x1SruZ/zSIz0VnxJXLK7SdGGe2PgLYayWZqNAqIflXkcp4UKmxwIA8vf7nCbXZNbOF
	 VAMuboo2WsMlTH5Ye3GtQL+WeSbO/BJnpiXTn5stHgYUzbIpnJ6aqVPTaQ2rd8pVAf
	 bM+9aDBbA2MZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 429CE80E9C;
	Mon, 28 Sep 2026 17:05:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3718C24E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30CB440608
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:12:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJa3vpm6gLZT for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 16:12:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B5264405D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790611934;
 b=rP3/MyKm8+wQHfjGozSdUGpb9E95z5/kX83WVxqViQraBjsMYtkwfCArs5TKZpQPCsh5
 a+boRsHxzz6+B90CYfbGZJW24Ti7c/EYvJuvKwggufC180ztkraIA5JbPYtOdVjPjERr5
 HlLi+kmn3wL0pdFplwTqTqj+xgeXfAIOVZJDRv6uyYCOawaie5TYQxrm1XNk9jsOuItp9
 jdM9+AjkoknQ0HQ0/N6YZ8AqI636P9b4eT5Ooj4J15T2IiwmSACA7//BBBQRjC/pcfDr2
 aCSrhuL5XYKKk705rJLHe8AYCtcg81R7VI9OR5+ChEPzZtQtJENgj+4M6dIsRqI5xyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790611934;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=JRCPVijiQDHCMC1R39Xvr713c3c+OBou2Svnurdf2hY=;
 b=YIYBYGQ6RsPIGlo9ypS1W87LRCjTNBqk6n9gdyNOnHtSGEsFhAH2/FW+RYrxbUBL5onY
 MFwyi+Vgt0sPs8RQgDZzV0XXLeSZkorZhkp3ol7KBxlQ0F79hJFSVpc7/Gh2FrlEHFehh
 ycyVwPcjjvqmCtc+aYuEmg8ngD2nb1RfE9BgJLqf7tAOav5EqI9QgQyenjWe6QlbEBGMA
 lWRIwcgGzdu3eUm2kqyZrA+6nyCLHdnNGcu0fxu8eI0Tuy3EeK1DzUPDFG8gnpjOH9xwY
 bNPzDrLdv+xguB0G3OgBkJxcRTP972AI0THZq8PkxKDSZIMOq/wCd3ZMuB3umT8uueg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=tekdjCVS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=tekdjCVS
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5264405D9
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:12:13 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c2946aa0d5aso28549566b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790611931; cv=none;
 d=google.com; s=arc-20260327;
 b=YbonbdDdy8e0fcwwRlogg8UHQ91tD/9baVpRw7tfkgrsJosDlEah7U++nf820HlUW7
 gGv4ROWcUaFGeyH0t8SoinJOTUeyWiwaeryW0yN3HXruTv5ScDkqbgzS3e++AnB/cVCw
 whDPp1hwXnPme6Lf1S2lVoFKe50TJzCO8PXVtAmATSOGXsjThAJZnyO528BKBYzwTBMu
 bu/vnMHJseC2ic+FN9kjNCCm0rYONSEcY7qJRQWFBrVw9JOy2ErvYXLgT/R9vRWygXVr
 NObzglZNTsUwbCSIYkU0ZE6DMfqaHtu1IbD4zdpNLgrzZj5OdaeX2uKlOAsKRDGlO2Z/
 6PUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JRCPVijiQDHCMC1R39Xvr713c3c+OBou2Svnurdf2hY=;
 fh=X0PN9lBUC28xruMLlb/E9GWPFyBweSpvg8ZgHdQS2Mc=;
 b=gKk7Evg89t86ACnMua32MSbaj7nlcO0f+b6uuQwX+n/NxgP1AUIB7fQPp8KqCdKxKL
 DjjKsGwOeavETkTpQ8s3YJFDyHQ2v8e1tuKapXRYtZA03+MVcxxv1mk4g5MWUe4peHXF
 dF/mZV70ABGXVaJwjx1H4DrDFjLhkWGPZhRQWCGxRJ9RkRvnaSM72fPG5oS1VxOVkNdS
 30IBL8dMLr09wt5OvBsSjiIL9EajR53ds9G0UqyvecGxi8tvkYVmGIx22Sc5mv0v81cD
 ot7ubmux7iVWE0qm7w/AE9YzIEjLRz957yBhS/+FWB6lO05RynqF+OhbCuMRMV1v53AW
 /oHA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790611931; x=1791216731;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JRCPVijiQDHCMC1R39Xvr713c3c+OBou2Svnurdf2hY=;
 b=tekdjCVSseck7okGiODgVMDL6jwlcpogdR8xNT926ct7nuyUiOLvYRgTKIekLCnN0q
 t9YxvSby1F1Q7hjrPpz+Rg+b91N/Ro3CjGLAYMTxpyvh1Jz6VGriXddN3ypdsTtOp2O8
 Lpg2j0DefCjl1+/mCBOmJNHJtQymh0AcoQ/vjZxr9leB2TGuOzUStE876RQudVn8dOei
 codgdB0R+sSK6CJZJAhiLjRrfLSp9ULJZPsOIwV4ABSJAHVe6TyV9xCiCC6OJUj2nFtr
 A98rOYUJ42XJEU3zami4gGJQFJxaotdCudqz88Wze+AkXUGZLxlM+L+EE5XRpC7SoHtd
 PEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611931; x=1791216731;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JRCPVijiQDHCMC1R39Xvr713c3c+OBou2Svnurdf2hY=;
 b=QwvKng6pPaGMFvgV9b0qKT0Xb6xB93o7taHtUcAujVwPGgyrNrBR+k+iIVrT0yZ+4H
 jz1PjFi409NhoGOYqEfsCtPcrRd/it5txO0LP//583oAujXoRej7N6ksnxSWm4I+Ysck
 vRDTb94iIU6tqUfwH8pPcp89z8bj3C2cAkKExT1rVwL32/arpZpU2dFR9QacWWmn8hoM
 dZw6V2ToJOY1FhoMMhpgNF/VpGC9paVX/EM28jKWAJzmtDpp5+ihgWv5f8ey5y9uzU0E
 tJ4Qjv0LM0WLVUA6wewC7YbKsKO6a0NpU1mX7BotiOoiLAXjlsIo10nMHs0/Z2vrFOhI
 GIFw==
X-Gm-Message-State: AFq9FYKYHNFaHIl+AhYZ3LSVa5qORUV+GoD7KKeQiRLGMb4H9l0AsE6Y
 nVGuF0T2aXyNwOiYb9oLsqYEGa2KtrE+tPa9LpC4hAh9oYPqiAoalXitQDpyTkOltNdYA7HhQyy
 xepuuSo+nOfC6vI0QH/sBsCdeud99Pk0UXjXYweVTRw==
X-Gm-Gg: AYBFou3Y04I6Leh00GJ4pbcWugL7KAognAxyz2EIsv9daHkuIkwv2mVIew5YsWQd5ml
 qNr1MGcxibsn3JtDdd6mk1rvqBkLbCWEjJkQM6A85qwZsGgf3WQ4bP9uGKIANcME+C+Dpcm9jkS
 Hg7xcU/t3oX2io1bFTqpJEDNp3HiMjnoqJXOrpNoydtcRA5NdyaInmEkFs7ifydfLverqZg5Vxy
 UZoWsXJikM/IKqIzrtCR339Cv0IkE8Na0UEG8B6EqWwnseIUjBbURHiU40apx4VifmsGxU2FnI2
 Dy5DVq4pfyc7Ierk9Qr0qfRH5Reop0jGe2Ky7r4Ocz8Oh7JEfFxoCDwC8qsPBulzO0aFYNG1Jle
 NbU/VgMs0ajUiLQ==
X-Received: by 2002:a17:907:6c17:b0:c25:32b0:e56d with SMTP id
 a640c23a62f3a-c2ac21f1b41mr1180115266b.7.1790611931162; Mon, 28 Sep 2026
 09:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
 <75fbfc49-a610-414c-99f3-9b86c1b415d7@cherry.de>
In-Reply-To: <75fbfc49-a610-414c-99f3-9b86c1b415d7@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 28 Sep 2026 20:11:59 +0400
X-Gm-Features: AclHuK_-d4tvGFz4sVG4TapSWy_fImRaSeIEITWSttz3X0tObnM9fg9DmhW4-08
Message-ID: <CAKTNdwEQSwVBaa=aRpAkQc5tj3Gz1iLK7ftCvJH-2jNiRwrMvA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode
 FIT images with TF-A+Linux
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 28 Sep 2026 17:04:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On Mon, Sep 28, 2026 at 7:14=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 7/31/26 7:10 PM, Alexey Charkov wrote:
> > Modern Rockchip SoCs such as RK3576 require TF-A to be running to provi=
de
> > firmware services to the OS. To enable booting Linux in Falcon mode on
> > such SoCs, add a binman template for generation of FIT images containin=
g
> > appropriately split TF-A and TEE binaries (as is currently done by binm=
an
> > for U-boot proper images), externally provided Linux kernel and optiona=
lly
> > an initrd.
> >
> > Any FDTs provided to the generator will be pre-patched with a /chosen
> > node containing an initrd load address and size (if an initrd is provid=
ed)
> > and a bootargs property containing the kernel command line (if provided=
),
> > so that the kernel can be booted directly without external preprocessin=
g.
> >
> > A config fragment rockchip-falcon.config can be used to enable Falcon
> > mode boot and the building of TF-A+Falcon with binman, e.g.:
> >
> >    make nanopi-m5-rk3576_defconfig \
> >          rockchip-falcon.config
> >
> > This will produce a FIT image u-boot-rockchip-falcon.itb containing TF-=
A,
> > TEE, Linux kernel and optionally an initrd, which can be flashed to UFS
> > and booted in Falcon mode.
> >
> > This can also be combined with the existing rockchip-ramboot.config
> > fragment to obtain images suitable for booting from RAM, e.g.:
> >
> >    make nanopi-m5-rk3576_defconfig \
> >          rockchip-falcon.config \
> >          rockchip-ramboot.config
> >
> > The resulting images can be uploaded directly to RAM via Maskrom with n=
o
> > storage or USB loader required, e.g.:
> >
> >    rockusb download-sram u-boot-rockchip-usb471.bin
> >    rockusb download-ddr u-boot-rockchip-usb472-falcon.bin
> >
>
> I'm sorry but I don't see the benefit for U-Boot to have this complexity =
in.
>
> I already find arch/arm/dts/rockchip-u-boot.dtsi difficult to parse, and
> this is not helping.
>
> Moreover, this has almost nothing to do with U-Boot, except:
> a) it uses U-Boot device trees,
> b) it concatenates SPL with the Falcon FIT,

It's that and also the maskrom-ready loader images which I'm producing
with binman [1] - though I haven't yet sent the respective etype for
review.

I must admit I'm not fully convinced this patch proposes the best
setup. I'm facing the inverse of your concern: my build server
needlessly rebuilds U-Boot for three flavours of Falcon Linux images,
only to discard the resulting U-Boot binary and use only the FIT
containing TF-A, Linux and initrd packed to U-Boot SPL's liking. It
surely feels suboptimal, but I don't see a viable alternative while
the U-Boot tree remains the upstream for binman and its templates.

[1] https://github.com/flipperdevices/u-boot/commit/316741fb254ad652ca8892d=
4fd52ec0ac628af69

> a) You should likely use the kernel Device Tree instead. Even though we
> sync regularly, we still add our own stuff and may lag behind. The
> Device Tree used for the kernel doesn't have to be linked to a given
> version of U-Boot.

Yes, and I feel that pain by having to reimport all my Linux DTS
changes on top of my U-Boot development branch to apply them. In a
"stable" world the two should be the same though, because "DT is
firmware" (or so they say :))

> b) You can simply generate this image ad-hoc with a simple cat (taking
> into account padding).

This would require splitting the TF-A ELF binary by section,
extracting the load addresses, and reassembling everything in a way
that doesn't deviate from what U-Boot SPL expects, including applying
compression in ways SPL understands. In short: I need binman and its
templates anyway.

> Also, this doesn't take into account boards for
> which there's only an SPL, in which case 0x471 binary should be SPL and
> not TPL. While that is already an issue with the current code (which
> would generate an empty 0x471 as far as I understood), it doesn't
> improve the situation. I'm worried about the increased test matrix
> needed for this, how do we actually make sure this still works and we
> don't regress? We would need a gold kernel binary and initrd on a
> supported board and test that.

Golden kernel binary and initrd don't sound particularly scary - but a
CI farm with all sorts of Rockchip boards supported by U-Boot would be
great regardless of my dirty little edits here. Not sure how to
approach that one, though.

> Honestly, all those concerns could be alleviated if we had binman as an
> external (to U-Boot) tool, then I wouldn't need to care about what you
> do with it. There was some discussions about which tools to move out of
> U-Boot's scope and we started with patman but binman was also on the
> table. Neha Malcom Francis suggested it could be useful to other
> projects, c.f.
> https://lore.kernel.org/u-boot/f697d6c6-3cf9-41eb-a833-880a892643c1@ti.co=
m/

I heavily second that :)

> I've provided one additional review below that may be useful for the
> other patches.
>
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   arch/arm/dts/rockchip-u-boot.dtsi     | 204 +++++++++++++++++++++++++=
+++------
> >   arch/arm/mach-rockchip/Kconfig        |  49 ++++++++
> >   board/rockchip/rockchip-falcon.config |   3 +
> >   3 files changed, 225 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-=
u-boot.dtsi
> > index 4ba6a87e78ab..5e23ff761751 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> [...]
> > +     fit_falcon_template: template-falcon {
> [...]
> > +                     ramdisk {
> > +                             description =3D "ramdisk";
> > +                             type =3D "ramdisk";
> > +                             arch =3D FIT_ARCH;
> > +                             compression =3D "none";
> > +                             load =3D <FALCON_INITRD_LOAD>;
> > +
> > +                             linux-initrd {
> > +                                     optional;
> > +                             };
> > +#ifdef FIT_HASH_ALGO
> > +                             hash {
> > +                                     algo =3D FIT_HASH_ALGO;
> > +                             };
> > +#endif
> > +                     };
> > +
> > +                     @fdt-SEQ {
> > +                             description =3D "fdt-NAME";
> > +                             type =3D "flat_dt";
> > +                             arch =3D FIT_ARCH;
> > +                             compression =3D "none";
> > +                             load =3D <FALCON_FDT_LOAD>;
> > +#ifdef CONFIG_USE_BOOTARGS
> > +                             fit,bootargs =3D CONFIG_BOOTARGS;
> > +#endif
> > +                             fit,initrd =3D "ramdisk";
>
> I've just had an idea now but can't we use &ramdisk here? This would
> avoid issues of typos between the property value and the node name? of
> course we would need a phandle for it (ramdisk: ramdisk) or use the full
> path (&{/binman/simple-bin-usb472-falcon/payload/u-boot-any/fit/ramdisk}
> (and the other one, as we cannot declare a phandle inside a template if
> the template is instantiated twice like here).

The etype should catch any typos I believe (I also have a test for
"randisk" in my WIP version), and multiple-references make the phandle
approach less attractive IMO. After all, a template is meant to be
reused multiple times, which doesn't fare well with phandles.

> But again, I don't think
> this is a good idea, I think we should rather do runtime fixup of the
> FDT based on an initrd property in the configuration node.

See my reply in the adjacent thread :)

Best regards,
Alexey
