Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8903DCC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 374C4404E8;
	Tue, 13 Oct 2026 15:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dY2PpTBt2x-p; Tue, 13 Oct 2026 15:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3602040554
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791903810;
	b=YrIv+EtEU2TSrBJOoWPwnS+28xd+rgG0MwGr6BpgDYbQEGziwzhP3lxs5aYllUXMOw22
	 jivv55ycQUZXJ2CHiwhNkfBSoAAVVqMwLtdg/J1dhPIMNkIxQE4RqzXKVOfQ3xHA4Iig3
	 RudH276K2Qe4DJ6qIgRGmknX61jUMXbRIdc01MvdKcqwlE4l9sm8WIN3Z9dQxIGbo70bq
	 YAAsRBmTb0o8vdtZr3VFjEo8nxSEzR6ApRy38ztwqNxJoYrkr4WH7d7bG59hIf2w/2qku
	 T282LOJuRpLnkachbSIs8jl7dm1HMFUGDKARwVrTLSTZKHWruOHlb1RIRCvnIxNdc5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791903810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S3p24w591scqZwtA7GjK5+CbUA9l8UGhcnXyci8M5bg=;
	b=tAzUT1wyhGyJBwarJ/G24duufWO7+n3EfTzfzEBQUEZlDif+tMG3is193YmnTY8y4JB1
	 anx9c3TRHnDgYAbCgNiotMCuV8lUSZHoFFUTebsK+R1aLTaC0E67r7/Vs5uC6RsYDuBRJ
	 U72GXFS8QscxHCyqofv7xdkQyvzEQ4VrEbg/KcpEX2JP44ls6hX53nrrlt66ifzbgbhlv
	 t+dYzUwiKHTJQzHHgbrG5PsQKItaVjpA9/lZB/63IJNrFaGnhbXcD4es0JXV8KyMtntWQ
	 0rs44oRZOTrCKo6fuYqPpvZZYprJGTunl6XG1ZfVjak4mbN1IgMNtzCcSMPsFLxseSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="fv/uhwnY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791903810;
	bh=S3p24w591scqZwtA7GjK5+CbUA9l8UGhcnXyci8M5bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eLgoz/3a0My3cwFS56QMu0EjpPbLdrUvp0DiVAS7nGQQ4CkMt8d55rDB4SCh57R+H
	 YmyenqCEtJSO2s50Q8MPSDz0zLW8S2j6XhUtavcP9DP3VN4JfaxmIW6P80OqKJRdgw
	 3dgThRQEj40ECqUBoPOW8g55LxlRBqoeuB3IwIOqTPTZ38GBNpj+8xZSHZU8y1+Wwj
	 ReypuMiat1GoHp8f7TxNtVfCgmR0HAdpFMARkC8+nccoI4TtB0J3bNo+uh529kS8Sw
	 azHxQWKFFjnVzsy+wl2UejXabyXLhAY04koihM9IjfUoc8uFxjI7aCEdubnUP53v/6
	 trZfzLD+pw/rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3602040554;
	Tue, 13 Oct 2026 15:03:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD789362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14D4540554
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id baDoYVMADk4A for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 18B45404C1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791903794;
 b=lvKh8SXGoTzaMKGdGwzdRm0lM+rN49Vz1PFDHtqx5JKIk5nR+J4lEBE+AP5zTP4DukOJ
 Wdp3YZbdOeji/ydd6WUSZAdZuFhE9YCmyLMN8DnScx0jeqSgehSX7kwjEy4CVVQw1X6B/
 e1bei0qc2Fafh0Qakk0XGCLFnh14BX4iCxp4q7/Eh6nWhnQtuQcfof5jlE6ljo/m1IeUW
 850kZUkU0/sk1esJjGBCl71Jm5jDR33sLqoBHvmOqJrXMHSAEZhqZMr2nNu0PZ1ZrL6lJ
 T7smk/Zalvu+EW32F6VtWUvaX8d4DFKrpcPIq8yTpDLuptZSIPyifqcLnB6fJ3VG4LQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791903794;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=S3p24w591scqZwtA7GjK5+CbUA9l8UGhcnXyci8M5bg=;
 b=cIauRX10VH7Oiyht1JuvEzaYeL3qTfEmhUV8UPk+aWkKhuL+1Jao1AptR9PT05qzxnPV
 fzEn6ReWDQGNLzRrKd7Uozrk9hnjiFREt9qAk+/ol0Gp/iO/boTPDYPsqLEBwe5z542Bo
 rXM+YVVtjDWTX9Rtn+oXxe4yIqsUAKBHqqIGz9GMk8QjWE6axk4LbM1lrRiZtUxWkEC8Y
 6tWbXDPSfR/JmPs49+xbzoOnEXfSCtd3JSzIi8SgZ6v7On0g3KWstrpIlRuy+r1Hl1yVt
 L/XESn/3REigcPpS05q4pOI3OFwYxpTK08/VXzFtyODsPz5cMkKLwEmgiG7+7Vu1rZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="fv/uhwnY"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::9;
 helo=mail-oo2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fv/uhwnY
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18B45404C1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:03:13 +0000 (UTC)
Received: by mail-oo2-x09.google.com with SMTP id
 46e09a7af769-821a4a69647so1321992a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791903792; x=1792508592;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S3p24w591scqZwtA7GjK5+CbUA9l8UGhcnXyci8M5bg=;
 b=fv/uhwnYyh63eHYf6MZvb5ryss08sktbDNBaEW9s0eFbsIRwz6x5PYbCW/NRDCr8wE
 guB/QGnvJEbUkwUp7lz9rsko+at5E9E87WSBEdd+nmKidj4fYurEfUawVbVXopbBxgtO
 d2xQIkApW3EdulI81YEbRDIMOj4pCQMl9jd2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791903792; x=1792508592;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S3p24w591scqZwtA7GjK5+CbUA9l8UGhcnXyci8M5bg=;
 b=fT7AFzLlmppg9IbJyakvEVvQq/ZAZ/uyQ9tm6x/CCValhe+73EtgzYfigi4TLiXY/I
 xODgNkdq7x+YW/DLy2xgUVtNAFS2H3ic0TQuL6BxqPSx6fcXRn7qKPNPzyhAhzNCoiP8
 4OLNVsQ7PCCad7olq1L7LCL+bidQCFkOmZNAeFEA8f6FDUK7C6Kg7LOPjXq3s8Uct4Tl
 DKyKwzeWuAH9/liMQ8q3zJMMhGdN1ISj6YMBrZuqw9Y/b2ni6GlpUlhMki5gPIVxAC4v
 1hfCEp/dm7pCkHVXImu5bWLTgHyvdTc3bcqQFIAgKYgKkNB4gyZOzM9f+WADBx6+a4Po
 JcqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBztVOs5nnta20srrhskW6h6y4hOuG2AmUFmhgPCDwRhoWiAZAzLglZKaqYE5YMyYw+K9ZdyZgU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJqItW6FgHaWkiqMil9xOJoqobaFNVb8F4dat5tKosrgamawtno
 t1qqqpzcOLSRWEwg7/n8l+J6OwexNO6gwSxJQ/m2GQ/o8eZfKSAuKpXcBVafdchIEqo=
X-Gm-Gg: AYBFou3J8CjurPYCAXoAbv1aTbJMbGISg4exto/sreL++8I+aPz+nksjhizNgxbIPgd
 kHZiknCfb1ssAjj1mirM64sMu9uOcliFLa+HSkUtM9OPZq6CeAcXYV3jFboc8yxXvPhfg1NGQb5
 IGl5LKQMu89oo4vuJFfR2EHvc5wCdRHyPpYhBlItNNoCEvheMfLMdyL7K2sPYU3as9pnXcErZF6
 uijq/VYF6ORCqYNAUf5hxwKqdKTOhaMaWJ6avaFzwKdD07/ErUlLwriZFNvS80VIfftosXL59N+
 l0s9PJyqGm2YDeZfXgUsEN75Nc+Rj4lEq6GS2oA/29U7UsMJbms3p5zjnCCjeGHJ/tbGEJsXwn8
 Y65djymOE/bXTUV81FbyxbBSOChMXfIxtlfERZs9EuzyZnvaRe/IiTaNyskbb/kHPwWfLNhU8cv
 cmP5Q19JZ3nLkbsJzLGNCUqQlaeC8IRQEQZcsRFaSsWImQlvU2PNFZXoWNeZUXRUXUZxoReuKTi
 SyWlRrPwqHEHzoZwLWQB3FI57AfYRsoCW92UuyXoEhR4rtnrVqQqPpoUHiYIYakcxz0LwI+8+MX
 KQgrNeE9/FIXT40RHdg=
X-Received: by 2002:a05:6820:8594:10b0:6f4:87df:79b1 with SMTP id
 006d021491bc7-6f487dfa59fmr3515348eaf.21.1791903792294; 
 Tue, 13 Oct 2026 08:03:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8303494f64csm12406906a34.3.2026.10.13.08.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:03:11 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:03:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Subject: Re: [PATCH RESEND v5 0/5] Add FIT multi-DTB selection for Qualcomm
Message-ID: <20261013150307.GB4042005@bill-the-cat>
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
 <20261012175042.GD3722450@bill-the-cat>
 <6bff4593-8182-4524-be00-6963ed9330d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="up9qGpObaqmW8Lhj"
Content-Disposition: inline
In-Reply-To: <6bff4593-8182-4524-be00-6963ed9330d4@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--up9qGpObaqmW8Lhj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:50:42PM +0530, Aswin Murugan wrote:
>=20
> On 10/12/2026 11:20 PM, Tom Rini wrote:
> Hi Tom,
> > On Mon, Oct 12, 2026 at 10:37:49PM +0530, Aswin Murugan wrote:
> > > This series adds dynamic device tree selection from FIT images for
> > > Qualcomm Snapdragon platforms, enabling U-Boot to select the
> > > appropriate DTB based on hardware parameters detected at boot.
> > >=20
> > > Qualcomm FIT-based DTB format is documented in [1].
> > >=20
> > > The FIT image contains only DTBs, while the kernel is provided
> > > separately as part of a UKI image.
> > >=20
> > > The implementation consists of:
> > >=20
> > > 1. Hardware detection infrastructure: Introduces the qcom,hwinfo
> > >     driver and qcom_hwdetect helper to collect hardware identification
> > >     data from SMEM, IMEM and TCSR into a single qcom_hw_params
> > >     structure for consumers such as FIT multi-DTB selection.
> > >=20
> > > 2. FIT multi-DTB selection: Implements DTB selection based on the
> > >     aggregated hardware information. The code parses metadata DTBs,
> > >     matches FIT configurations against detected hardware attributes,
> > >     applies overlays, and loads the selected DTB for EFI boot.
> > >=20
> > > [1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/
> > >      Documentation.md
> > >=20
> > > ---
> > >=20
> > > Changes in v4:
> > ... which was sent as v5, and this is a re-send of?
> Yes, this is a resend of v4, which was sent as v5
> > > 1. Drop the SMEM cache infrastructure.
> > >=20
> > > 2. misc: qcom: add qcom,hwinfo driver to provide a common interface
> > >     for reading IMEM boot cookie and TCSR SOC version information.
> > >=20
> > > 3. arm: snapdragon: add qcom_hwdetect helper to aggregate hardware
> > >     information from SMEM, IMEM and TCSR into a single
> > >     struct qcom_hw_params.
> > >=20
> > > 4. Refactor FIT multi-DTB selection to consume qcom_hw_params instead
> > >     of accessing SMEM, IMEM and TCSR data directly.
> > >=20
> > > 5. Separate hardware discovery from FIT parsing and DTB matching
> > >     logic, reducing complexity and improving code organization.
> > >=20
> > > 6. Load FIT images directly from a raw GPT partition and remove the
> > >     FAT filesystem image based loading approach.
> > >=20
> > > 7. Drop IH_TYPE_FATFS, mkimage FAT image generation support and
> > >     related documentation updates.
> > >=20
> > > 8. arm: dts: enable qcom,hwinfo on qcs9100-ride-r3, qcs615-ride and
> > >     qcs6490-rb3gen2 by adding the required qcom,hwinfo DT nodes and
> > >     board-specific offsets.
> > >=20
> > > Link to v3:
> > > https://lore.kernel.org/u-boot/20260417120951.3454249-1-aswin.murugan=
@oss.qualcomm.com/
> > The FAT comments in v3 were addressed. I'm not really sure the discussi=
on about if
> > this approach makes sense as really was addressed however?
>=20
> Yes, the FAT-related comments from v3 were addressed in this
> revision by dropping the FAT filesystem image-based loading
> approach and loading FIT image directly from a raw GPT
> partition.

Right, thanks.

> Regarding the broader design, the reasoning for using a
> DTB-only FIT was discussed in the v3 thread [1]. The intention
> is to support firmware-side DT selection while keeping DTB
> management independent of kernel packaging, matching existing
> Qualcomm deployment models. This is intended to coexist with,
> rather than replace, approaches such as UKI DT bundling.
>=20
> [1]: https://lore.kernel.org/u-boot/afSXa7q7hJC_ZW07@sumit-xelite/

Yes, and I'd appreciate some of the people that were discussing things
in that thread chiming in and saying they're happy enough, as it wasn't
clear to me in re-reading the thread yesterday that the discussion ended
with agreement and instead just stopped.

--=20
Tom

--up9qGpObaqmW8Lhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas5IKwAKCRAr4qD1Cr/k
CvHxAQDmLdgIkFe5S8kFsYlXsBRPVgxLoXu0U3vEclQQslo/PQEA1bUb8F6QezNg
uhlX9uUQ/aSE/pgpP2a2W8Kegep3NQg=
=Gj0y
-----END PGP SIGNATURE-----

--up9qGpObaqmW8Lhj--
