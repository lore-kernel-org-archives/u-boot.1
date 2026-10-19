Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0216CCCF2D3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96EB0406FC;
	Mon, 19 Oct 2026 08:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQpJq8KY2E6t; Mon, 19 Oct 2026 08:08:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 52A85406EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792397294;
	b=Ua6NCLAP1Jb95bTv++dsK4URrUxClRik9+DINb9sSRSdmVfIU2zcCG+96VgBiA5uMMGi
	 2v1axhDZVbAaN7nMu0HqKfE3LgpG00Tcv6+Fl1z/gOFe+z+bfI3XJu1zYhGDh503ZFd+X
	 z4+NUzRljwxyxVi9a9BtVueF2iHT3v5y+PbtGNZhNJbd7iPpZUqm+3h8d/Gxwjm5lilEe
	 aemvLeczZfcwsTI52gaTZEi52Jsn9l4VufkJF9E1GndGLpXk04pnbsrCEtEGyNRHJQyLT
	 KuqqLqk7iCU4DsLUxlHICgOzqLmbmMMtSA9ClwScKuJhdYubnot+KqSUiinWaiqvpcg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792397294;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eywCivJb1N6P8vrmHNpcZAlTNFaTM9+Exc/FA+VftVE=;
	b=Jag7dusxFL+s2WFJgIG0QrUdn4j0YBWWbuP48NlHtuxvecGYFYhKBw9cPM2gWxh4sGlS
	 0xJNesOmJvxG8IQFeOKz179RDiJw2pubCwhmCB5dXkFm1R7L5RXVLBarP1XElzs6O07+O
	 Iv4gGJrmpwu9vkJdf/y52U3wbvB14g/wlWnthGyNUFTCGVBbrKdxZfbEezIwAOoRs90AO
	 pqXypJx0S7/gGti0kWf6GA/p3oj0Fw4ZTC1EECauxSI/PiI10dvrsjkaQOPfo7h3HzIMY
	 amjpwVaxVXNfqHv+xv/Se0kdqu4uSml+2kOQfOlYcHnzF1K66M9eeK9En3ugHt7l5KQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a7jROOML;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792397294;
	bh=eywCivJb1N6P8vrmHNpcZAlTNFaTM9+Exc/FA+VftVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yejp4EEBlfSJp1dtEZDTrD56z7xr0TOKRb4iFWCsnMwBwadvheEdHioTSF3oWqq2K
	 RGc3syeuxRjJNpO4LYpsRfmf5hnTqZ4lZDkljW2wqXPImZAHDiZWxmBsAlocBJXTeW
	 khpyGwBTZsqUMM9G8nRycrnTqlXd5ta95LD6nigXEKEhX7t9hZ1YkAbkUPwlC+MZ7M
	 OiXcECNqGoq3WDgmlF8cNBS0/UfzvD53CBHORTllit1bDt9YVVBfDCwkuO7r0ZAqb2
	 HGl9OklMK18euUpYZxm70YodrpuiK05IkMAp0OSr0O+qk0BZfjJnHy201u45rW8CE1
	 SL5Rjho9z0h5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52A85406EE;
	Mon, 19 Oct 2026 08:08:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87BDE263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7923E406EE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NzTmHS9Jtw5k for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:08:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C854A406E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792397291;
 b=eDP28GV7IWe4CIrx6DUpKsk55EfBDdTzzvPnFC0NxwKVTQ3W5v2GWRgiPG872WxQWqS8
 1VPApdiKv/4jddkxNhQDkSGCk7cPHtO4A1Xvl3cpHWkNcx65NEjS35mIz9WUnmurttAnG
 sw+sAS/Sj4yXFxPnKuNpcTf+dxiKaB33HWDl0oZdZw9LhJX3sALFMm5bgAfhxgjzIkeEJ
 uK31aXNXthbNbrdjbkwoYtynuplspI++AlGj7ghK95aNlsoA/aOtOxleGQQlsOP0vlQc/
 YDQ1g5ulhUBvHzd3n62t+E9TovQE2t6V/Io+imKx5fVE49uKhRHvJ6zPmZgQrDh+1gw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792397291;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=eywCivJb1N6P8vrmHNpcZAlTNFaTM9+Exc/FA+VftVE=;
 b=LrNo7WppBHVJR1d4ZF/tdEjF57aqad0W0mq8jo321wmUG6pzVSA0otJjSN9qm0YZxQuH
 y0sl3gEXqvoQO+Vx1SP6S6J3ntjWSVNI81Kvo6ig/Ny+RbBhsf6pysOGnreda+zCdUcCb
 YJJGjktfA27G45uUi5Ncp2Bb7fOUy+xni63ZuyEAJdEsCAVfz8cACZtpIlc3wobgYtfrQ
 NnzzMErgThpfgZ4w9hdxcrXGb6ooQ5P0AFH449OhXSzTxDmpPsNiCdBxwlEMprRPcwgie
 tP/xiImj0EQnZmIRDm5Mge6nAokYNdWafDtZbTwXd0zxCEMXVHcWdITPpZ//nLyzhNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=a7jROOML; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=a7jROOML
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C854A406E0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:08:10 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b0d126f631so12995247b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792397289; cv=none;
 d=google.com; s=arc-20260327;
 b=IQ5J+E8uSHgYyovKial8xwwNR0Z8RwaCDHGxUYD4BUnPd4Tr6JOWme3ywkkA12FDsW
 2vl+Om49lYo/aioSW49634JXBVFjSJIBrML6UezgvKB8h6AP4cyEwzT8TMLmWclKsQw0
 VK1Ru03HfWWtnHXc/NJjAatw0cng+PPUkNfIVS1IXIpA8pB/JyNa5S0iz01t/H/fbWi8
 isnV8lG2LpuJk1ALXfWpuE6P+1cuatEMHOLPPTIw3JzKLAibDGX2PAeE46/OBWtEHWf4
 grcRfD1bl5Me3/1l0o7SjcNMhPzu44ZnpkDrpsAoXbfhC0W5EZ2ANSn0zkTXy3JI2pLt
 LDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eywCivJb1N6P8vrmHNpcZAlTNFaTM9+Exc/FA+VftVE=;
 fh=ZMQAWUnDfpwxin1KF6Oilti3E6t+JoeIer69CNYY87g=;
 b=PHKLTtRWPm/qXJJFY1eJCyg3111QpbShAy2yZVmj5POShrOG1eMm3sMVjWMnGBoiqu
 a62DJgQWwWI1Jk80aHCSPZBruZ+16/Vhagjw9+ggezWmJ4i+tH1qPsq3DKzCy91h1dnI
 VidduVsqjoCXLiLUS0zQ8ekPLaxOTBjaAxYuxlKZD1hGJas7mgVJk13HtTFUtX5x1EP9
 jDL512wm73j6mc5Ki2E2nQ7iEg7q3mG7t6ui5O0eqUNPd2ge9gTkeBj8CGGnkFu4xtpp
 1xdQf18D7sOuLiUp8pz61yhoyFQwrtXvpZoiHSeeavpefS/DrQZiQKd/lSC7oZ+4swa/
 zc7A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792397289; x=1793002089;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eywCivJb1N6P8vrmHNpcZAlTNFaTM9+Exc/FA+VftVE=;
 b=a7jROOMLkcsmq/Kv/g082Emibt9/ZUZzYu2LiyF2qwU3Z2VOp9MqpixR3fQVgtbHlR
 +m4jaBi26RSYg9NVGF0zC349JZlq3z1kGf50PQqJU8ePxGi6eYtsAoAbhmDY35vTibYC
 BntvEoZXbuza5/d4bDRZP92gApf7+InvqEVu37IMlP2fpGSicWMvRjE1lo+7VtF3ygIl
 G3rs4jZtbAX1UPnenkCBhbd4YtgkCWIQYhGLX1St1Ro3fBWf03x5yR/FEjfAdEB09D8q
 KXwX1L1+GaDrWM7l89zMywByTun34yvUajsGH/orr6dny1OANlpWjCLGsMdB5Cpbh35L
 hc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792397289; x=1793002089;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eywCivJb1N6P8vrmHNpcZAlTNFaTM9+Exc/FA+VftVE=;
 b=rzfq0ojg2+w4Es8uv6ddjWCryjXMbYdvWA3CcOatyjp/gUJeghZIIyfyPTdDWAYdQt
 oQhp4bo/33ouUEPllHFr6jcvEMxpUNViMOAwjbqsAldgcR/eYGYsYMF0ShdsUIJuTSWM
 alcbbUOxU8qNghrW+MtERY/38oOLCRBfyG5Q4hd/OQxLRVO/3czcQrb3Md/CqUxZ25Q7
 Yg7fq1F6Ir7TBp2VZ+Ca2jicI8sX1VZQ6DRq3ia8oZvQuekXRRamiO4pRn+X8MMikbpi
 w/FKAhPN2RfUW8F/PTRiPLwGtJ3XspOe0dJTq2tM5M/vHg12ronKDbH7OdAPWW+2qo7i
 JLZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2AKM6Bmu8QP9XJHf9lMDPtO+LSwqPutsT8d5lkjv/uBtAmd/6KQ2OV2Bal+kEPDhBUEKfKrA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLKps55JpuC6Jly1Kv0OVqFneKcWlZ5pSfwYTZ14NkM7QK/llrM
 oYac/0daCDAqHn9CAs/LnYU4g3q1dRyOe/p8dmVyhy2WrUGBk/wkewWNG3YOkdMIywp+VQua7tS
 IlLK6+cSAsWf10+4cnK2/VTHfwy8laC8N7V++CVRz8w==
X-Gm-Gg: AYBFou2NlcoCU01Mtcuz5TZolnX4ybTxYCS765VlbP/dZfbBq5JDcPz6iz9mE8JSWhO
 agJAVLw2R27pxR4jiugAO9O5osJA5UTL4AXvdOuj3+w9ZQWfbPtd0V3c0JtO8j6ZsYtCp6MvoR1
 7Z79cRXZQJh2wTPF3giZkavKIAL46ktwadQBKX71LFhjHKskmPzQg9DcrFJoCDVtuRBUYwXwpW/
 gX95X4YXJ3FpLp51smoTse54231OkjF64B78fKRRE64JyEonMaCM5qT+tsUad5NdNErLl9ESToi
 6m3I7csQGZW0+Z82K430DGcbTMfYdhYTBPQUc0chncMv3KjeUeMzjw4MRz/PsTti0YE4w4al1j1
 eDMh9Od1RiKO6UHGAjpTX2cosH72NmPP9m0tAe8aWhBFd6/T/P5LkKGxKKt8fHEZIv9a6rreFdX
 jec1QAb77E2Yr/4fhIJG5ALKJQwhst8x7+DsIuBUEaDK3ncRn1e6FlLCPi2RuFVpJln8Tlk/6sd
 F9XoLCXSbcMl9DlPQGpLIXzelhqofbEERXdSyIfNmwJ5K+8/xUsKNS9OzZO8J7IFaX7OA4QJypN
 xg9lJ57yzyzTiBN0tQ639PJ6qOluSGZ9oVuvYIIHxnnKK5DBRamB1RRLFeLw0qs/xDCH7qGMAfW
 mpzWmckJZdFWAOxoTHwmdWsy/5KcCnTclT6FCydDWC1Dxnv5qIyVHc306dBrM2c2w
X-Received: by 2002:a05:690c:298:b0:8b0:a176:fa5b with SMTP id
 00721157ae682-8b0f21e1720mr23732697b3.64.1792397288666; Mon, 19 Oct 2026
 01:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
 <20261011-upstream-optee_rpmb_b4-v1-2-7c63edca4b92@oss.qualcomm.com>
 <77d8fc9b-ab0c-429d-a1e3-05e558188f45@siemens.com>
 <CAPzfCAbc6JQBz+VR0O72Zd7csNBSC-QSHtbnrHLL=E4g=ZKEAg@mail.gmail.com>
 <41365552-6c51-4cd3-8899-0bb5c2907aeb@siemens.com>
 <CAPzfCAZcP2soDNCpfpotaDF+h9vm7L+G_4_khZpG_R=rFdVyeA@mail.gmail.com>
 <9d178f6c-de2d-4f30-82a1-d235a0f88fcd@siemens.com>
In-Reply-To: <9d178f6c-de2d-4f30-82a1-d235a0f88fcd@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 Oct 2026 11:07:32 +0300
X-Gm-Features: AclHuK-SN8J0aB7OPwT8uvXdtnXoeT3-CzzGQ_Dyg4t8gc0wtltNPVDd60jBol4
Message-ID: <CAC_iWjLMhZVSYhF6O_wZ6rioh1HFPkdRRnO28hMpQF2EC9L0+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] optee: do not announce RPMB from within a supplicant
 RPC
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, 
 Jens Wiklander <jenswi@kernel.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Jan, Igor,

On Tue, 13 Oct 2026 at 17:30, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> Hi Igor,
>
> On 12.10.26 19:03, Igor Opaniuk wrote:
> > Hi Jan,
> >
> > On Mon, Oct 12, 2026 at 11:14=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens=
.com> wrote:
> >>
> >> On 12.10.26 10:10, Igor Opaniuk wrote:
> >>> Hi Jan,
> >>>
> >>> On Mon, Oct 12, 2026 at 7:42=E2=80=AFAM Jan Kiszka <jan.kiszka@siemen=
s.com> wrote:
> >>>>
> >>>> On 11.10.26 15:07, Igor Opaniuk wrote:
> >>>>> mmc_init() calls optee_rpmb_available() once the card has been set =
up.
> >>>>> When the first initialisation of the eMMC is triggered by the RPMB
> >>>>> supplicant, that is while OP-TEE is blocked in an RPC and holds its=
 RPMB
> >>>>> mutex, the announcement opens a nested session and OP-TEE's second =
thread
> >>>>> spins forever waiting for the mutex (U-Boot has no notification sup=
port
> >>>>> to put it to sleep). This happens whenever a TA touches its RPMB se=
cure
> >>>>> storage before anything else in U-Boot has initialised the eMMC, fo=
r
> >>>>> example a TA call issued from the shell right after reset.
> >>>>>
> >>>>
> >>>> How do I trigger this exactly? I tried via StMM (env print -e), but =
that
> >>>> didn't cause issues in my setup.
> >>>
> >>> The first mmc_init() of the eMMC has to happen from inside the RPMB R=
PC,
> >>> i.e. nothing in U-Boot may have initialised the card before a TA touc=
hes
> >>> its RPMB storage. On QEMU virt (eMMC on sdhci-pci with an RPMB partit=
ion,
> >>> OP-TEE 4.11.0-rc1, environment in pflash, no "mmc" command, no bootst=
d or
> >>> EFI block device enumeration before) it is just:
> >>>
> >>>   =3D> optee_rpmb read_pvalue test
> >>>
> >>
> >> Seems my setup lacks the AVB TA.
> >
> > Any TA that touches RPMB storage as the first eMMC user does it. Two
> > options without AVB:
> >
> > - the fTPM TA, if it is in your OP-TEE: with CONFIG_TPM2_FTPM_TEE,
> >   "tpm2 init" right after reset is the first eMMC access and goes
> >   through the same RPMB init in tee_rpmb_fs();
>

We did briefly touch on this [0]. But I couldn't reproduce it locally

> This won't work as there is no TPM before we got informed about the
> presence of an RPMB and therefore probed for TAs that need one. The fTPM
> use case was the driver for the callback.
>
> > - the AVB TA itself is in the OP-TEE tree (ta/avb), so
> >   CFG_IN_TREE_EARLY_TAS=3D"avb/023f8f1a-292a-432b-8fc4-de8471358067"
> >   together with CONFIG_CMD_OPTEE_RPMB in U-Boot gives the reproducer I
> >   used.
> >
> > StMM cannot hit it, which is why "env print -e" is clean: efi_setup.c
> > registers the EFI disks, and thereby runs mmc_init(), before
> > efi_init_variables() opens the session to StMM (there is even a comment
> > on that ordering). By the time StMM issues its first RPMB request the
> > announcement has already run from a normal context based on the code I =
see.
> >
> >>
> >>> right after reset, with CONFIG_CMD_OPTEE_RPMB (any TA that uses RPMB =
does
> >>> it, this one talks to the AVB TA). With patch 1 alone U-Boot never co=
mes
> >>> back; with this patch it does. The OP-TEE log (with CFG_TEE_CORE_LOG_=
LEVEL=3D3)
> >>> shows the sequence:
> >>>
> >>>   D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA 023f8f1=
a-...
> >>>   D/TC:? 0 legacy_rpmb_init:1219 Trying legacy RPMB init
> >>>   D/TC:? 1 tee_ta_init_session_with_context:578 Re-open trusted
> >>> service 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> >>>   D/TC:? 1 do_notif:34 sleep thread 1 0xe9b3d570
> >>>   D/TC:? 1 do_notif:42 sleep thread 1 res 0xffff0009
> >>>   D/TC:? 1 do_notif:34 sleep thread 1 0xe9b3d570
> >>>   D/TC:? 1 do_notif:42 sleep thread 1 res 0xffff0009
> >>>   ...
> >>>
> >>> Thread 0 opens the TA, tee_rpmb_fs takes rpmb_mutex for the RPMB init=
 and
> >>> issues the RPMB RPC. U-Boot's supplicant runs get_mmc() -> mmc_init()=
, and
> >>> mmc_init() calls optee_rpmb_available(), which opens a session to
> >>> device.pta (PTA_CMD_GET_DEVICES_RPMB) on OP-TEE's thread 1. device.pt=
a
> >>> runs tee_rpmb_reinit() and blocks on rpmb_mutex, held by thread 0, wh=
ich
> >>> is itself waiting for the RPC to return. Thread 1 then tries to sleep=
 via
> >>> the notification interface, U-Boot answers TEE_ERROR_NOT_IMPLEMENTED,=
 and
> >>> it spins (about a million iterations in the three minutes I let it ru=
n).
> >>>
> >>> Your StMM test does not hit it because the eMMC is already initialise=
d by
> >>> the time StMM uses RPMB: the EFI subsystem probes the block devices b=
efore
> >>> the variable store comes up, and an environment on MMC or any earlier
> >>> "mmc" command has the same effect. The announcement then runs from a
> >>> normal context, and the later RPC finds an initialised card.
> >>>
> >>>>
> >>>>> Track whether a supplicant RPC is being serviced and skip the
> >>>>> announcement in that case: OP-TEE is using the RPMB already.
> >>>>>
> >>>>> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> >>>>> ---
> >>>>>  drivers/tee/optee/core.c          | 3 +++
> >>>>>  drivers/tee/optee/optee_private.h | 2 ++
> >>>>>  drivers/tee/optee/rpmb.c          | 9 +++++++++
> >>>>>  3 files changed, 14 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> >>>>> index a47c76811cd..b61f907a3ff 100644
> >>>>> --- a/drivers/tee/optee/core.c
> >>>>> +++ b/drivers/tee/optee/core.c
> >>>>> @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *par=
ams, uint num_params,
> >>>>>  static void handle_rpc(struct udevice *dev, struct rpc_param *para=
m,
> >>>>>                      void *page_list)
> >>>>>  {
> >>>>> +     struct optee_private *priv =3D dev_get_priv(dev);
> >>>>>       struct tee_shm *shm;
> >>>>>
> >>>>>       switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> >>>>> @@ -450,7 +451,9 @@ static void handle_rpc(struct udevice *dev, str=
uct rpc_param *param,
> >>>>>               break;
> >>>>>       case OPTEE_SMC_RPC_FUNC_CMD:
> >>>>>               shm =3D reg_pair_to_ptr(param->a1, param->a2);
> >>>>> +             priv->in_supplicant++;
> >>>>>               optee_suppl_cmd(dev, shm, page_list);
> >>>>> +             priv->in_supplicant--;
> >>>>
> >>>> Wouldn't it be enough to track this from rpmb_process_request? The
> >>>> nesting issue is limited to RPMB requests, isn't it?
> >>>
> >>> The deadlock is, yes: only the RPMB request is issued with rpmb_mutex
> >>> held. I put the counter around the whole supplicant command because
> >>> announcing RPMB from inside any RPC is pointless (OP-TEE is already
> >>> running and will probe the device when it needs it), and because a ne=
sted
> >>> session from an RPC occupies a second OP-TEE thread, which fails outr=
ight
> >>> on a build with CFG_NUM_THREADS=3D1. A request that is not RPMB can a=
lso end
> >>> up in mmc_init(): a LOAD_TA request served from a filesystem on the e=
MMC
> >>> does exactly that, which I have in a follow-up. But I have no strong
> >>> opinion; if you prefer the narrower scope I will move it into
> >>> optee_suppl_cmd_rpmb() for v2.
> >>>
> >>
> >> If not only RPMB requests could actually trigger this, then having it
> >> over all commands is fine. I was just wondering where to place it best=
,
> >> here or in some of the invoked functions.
> >>
> >> But looking at optee_suppl_cmd(), though, I guess optee_suppl_cmd_rpmb=
()
> >> is really the only one, no? At least it would look a bit nicer to do t=
he
> >> state tracing inside optee_suppl_cmd.
> >
> > Agreed, optee_suppl_cmd() is the better place. I will move it there in
> > v2, together with the local variable in optee_rpmb_available().
> >
> >>
> >> But if you have more requests on the list, I wonder how that will fit
> >> into the picture. Maybe you can share the full set of changes to get t=
he
> >> full picture as well?
> >
> > the whole tree is here, on top of next:
> > [1] https://github.com/igoropaniuk/u-boot/tree/android-avb
> >
> > It fills in what the AVB and A/B implementation in U-Boot is still
> > missing to be usable in production as is: the device lock state and
> > root key provisioning, verifying the boot images in the buffers they
> > are booted from, init_boot and dtbo, the managed dm-verity mode,
> > rollback index updates once a slot is known good, loading TAs on reques=
t
> > etc. Everything has been tested on QEMU virt with OP-TEE and the Cuttle=
fish
> > Android images to the point where Android reaches boot_completed with t=
he device
> > locked, and it is being split into series for the list.
> >
> > The request that matters for this discussion is
> > OPTEE_MSG_RPC_CMD_LOAD_TA, U-Boot serving TA binaries from a FIT image
> > in memory or from a filesystem so that a TA (the AVB TA in my case)
> > does not have to be an early TA baked into the OP-TEE image:
> >
> > [2] https://github.com/igoropaniuk/u-boot/commit/2029a3bd16641668ed37bd=
19d7a0f0570ba795c6
> > ("optee: load Trusted Applications on request from OP-TEE")
> >
> > When the filesystem source sits on the eMMC, that request is the first
> > mmc_init() too. There is no RPMB mutex involved in that path, so it
> > would not deadlock, but it would still open a nested session from
> > inside an RPC, which is pointless and fails outright with
> > CFG_NUM_THREADS=3D1. That is why I would like the tracking to cover eve=
ry
> > supplicant command.
>
> Understood and agreed.
>
> >
> >>
> >> And what does the Linux kernel do to prevent such deadlocks?
> >
> > It never announces from inside an RPC. The RPMB device is created by th=
e
> > MMC core at probe time, long before any TEE client runs, and the OP-TEE
> > driver reacts to it through an rpmb class interface notifier that
> > schedules optee_bus_scan_rpmb() on a workqueue (drivers/tee/optee/core.=
c),
> > so PTA_CMD_GET_DEVICES_RPMB is issued from its own kernel thread.
> >
> > The RPMB requests themselves are served either by the in-kernel RPMB ro=
uting
> > or by tee-supplicant in the user space, both separate contexts from the
> > caller. And Linux implements the notification interface, so an OP-TEE
> > thread waiting for a mutex is put to sleep instead of spinning on
> > TEE_ERROR_NOT_IMPLEMENTED as it does with U-Boot.
> >
> > U-Boot obviously has none of that: a single thread serves the RPC synch=
ronously,
> > hence the explicit check.
> >
>
> Makes sense, thanks for explaining.

[0] https://lore.kernel.org/u-boot/CAC_iWjJaBtq5r=3DDJtdf_UWUxv0Hn6PrUFXi9x=
xDT86BdHibtFw@mail.gmail.com/

I'll pick up v2 shortly.

Cheers
/Ilias
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
