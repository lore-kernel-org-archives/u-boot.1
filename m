Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6981ECA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CBF9810F9;
	Sat,  3 Oct 2026 13:03:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ua_DamrDTYj; Sat,  3 Oct 2026 13:03:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 49960810FB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032592;
	b=GJh5aIZxoR8kpApB4271mVgB9mfL9Qn8Jfh1Nyn7hV+snG2wVOuQBhiirGlpzNlNCQy0
	 vM1zSzoxYIKGGdX3TiOK8U5EzWHpmJ1KJwNm9fKqvFnPD70sy0Zi6wzGccp2h9rI1qCfH
	 m2lAPgew4JuZsuaL9InhhemZ6pmEmCFPJIXLYzKtEQRxeDqMbFRpr2bMAJX9IRKtEzcsL
	 neWQvevCtmX8FsW/NBe9eMDRBH9kGhTQ9obilxJaj+d9U8shFu7jRkzR2PA7TmRxLASY1
	 w++4BROLv31WGJEl1HmVCj4ivwKu56nxIpsgHiNwBBzIclh1fMmLz868HkKxPRPXpUw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hQJ4RoG+mTPof9fejasIJ0C73P3MgaTENhk5o1AZO/o=;
	b=kRM+dUZ2/6OWU/ZMEDs/TED8XAYAul3fhkWO7RGw+dvAlxgUrWar4Tr5H27E+dbqrLBK
	 TBl44LhEVhLcy+z2YPqrvdzgsS1jXStdG+rt6khGbro2d+/mOYcKlrclfSyiLh1/HXdIp
	 QhNkjxSrkgXo4tH8M4lBQK4bSwsaLTtR2IwzzWQfaH+PPoVeA7rMC6mAEGC92qVB56TVe
	 3jeLlh+HkZk1XpTw63yD3jQtmwIloFGIDUqa8i8IOIKONUjHEk6KivnYqSGXeu39+BzmD
	 Z+Qm9xV3dThPjzcAbebV2SecmZpPON2pTsPq8xOFNaw8nO1tRPnpnYjj/piF+7wA+CA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032592;
	bh=hQJ4RoG+mTPof9fejasIJ0C73P3MgaTENhk5o1AZO/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dUB8kjey48H8LIoIRWhjEw/ytlyskBYC6rDb+hpF/8MhhWA6xvFz2Hs1IxIBLCCut
	 oRlIs97TXe9cWEJ3Hulmq2oJOuCjbp2ZkO723E8kd5Z5TflLSrAGEIcZMLCpGEATdA
	 wQTMDnwTkbrmFDqMQeFxstwfLtfhnoY48CKLa+9gLU5VrUTYrQ9Ff583Oy/oyZDnaZ
	 yyVw6bHtD59og+RFmeCUfwhPjxf8uk6DDrdj/+1K1tVwU32AHklqfD8/itRsEiApBs
	 Uuy8WMD8jPkk0fKDi5M2cCfbTS00v3ph8aEWdOF/Yqk9kNZzUlqVa0Hzk6cKE5gDlF
	 QSSgu7gE+NwCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49960810FB;
	Sat,  3 Oct 2026 13:03:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 96C79179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7CF9140063
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:03:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4bXIUH_-ec7U for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:03:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7A24040024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032589;
 b=Wtwg9JwDmSTL26PpVRFakruA1HEU10Zs43VhT4FEWfHphYH5G45LFZbyGzVccfpJ6zHa
 hR/+8dZaSVFmd4M8zM1ZP6sofIHPtNNXZOCI/+4frEC9LDvnE8qq0pbXiBFCj3flz2frK
 ZWx+Kt2vRDrfPeZCA0LbQ2GtwkQ2e3oG77Oad85L9KvNlVr8UzhKg8Bbfym8B7tHlsLr5
 TEDOgrcIoPW5EoZozpKP2+hVGZ67J3/ZDf9TH+HtqWc33sfPs58ymkt56tnShgcjEnuS+
 IxeS9hiUrPZ8Yj3kIGR8UO9Yos+skkyxF3a45CglgMTj3XW8MeLR+wGS/TeEI6gI9Fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032589;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=hQJ4RoG+mTPof9fejasIJ0C73P3MgaTENhk5o1AZO/o=;
 b=UcpMwqAjRoHR2QONKQaAoWPjt8W3wb5yuj+wVyRTQr/aKXP6cUS428YhjHbwECPvdhrX
 7Q20NE3+wlYHKF3uJZlBXEdJddmKPIkoj1fHfnAhlb1XHw2JPpzAvpDyoekQtUj4x+9lt
 xvX4MhoF4sKkjh5G06zEVbu1hEbH1pTYe3go93kHXFFFKVCEn4f+Y+KyMKfup/0MFvOng
 3arYzRqbFqzpbgAGSA8qCd6i6F0an1/y5Eo+g+ffNl/YKIpFDfsao3MPxdea7mHZKwdHj
 UqIF255HfrOhO0OTrhufBTzezK95emffs2glAtcj9hoSEkvmKkY/LUrLAt4t/h/TOzg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jiJ5NIps; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=jiJ5NIps
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A24040024
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:03:08 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so539888a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032587; cv=none;
 d=google.com; s=arc-20260327;
 b=PoNYZ00jsyDUEpqs+q3XEQVToFJtxIGhw19QDnwNonRK2rFS6ol6VYgNUXstcbAEw3
 p0gX72LU84TDRajDx0BoHBQhrLkGF2K3QlN6hCkQTKPSN3/iZxbJnRK8+vzFE7UQmIIa
 a9uRCdtWZKfoOy7x5+E+V1lpt0aFtPREUgvWBtD/ppQPFXJ7iaW6KcOaJD9cEaZHVlHU
 GkcnUA48Rzp20umPjdhU4GF7Z8UXWI3I+2It4rDXu8fk6HDrLQLScWGKKQeb61m1HZE9
 pkX5+N/HWwymj2AX0ZkXKd6e4TkgyI7HWMXbPkHm9y3e0Wu1TYEP6wGjhrmpySgvbYFF
 yK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hQJ4RoG+mTPof9fejasIJ0C73P3MgaTENhk5o1AZO/o=;
 fh=BEoPNN0ojtgxNz8fjZSoyMObtb+XDDU+qZjnWDTAHBk=;
 b=F5r6Ox5zZ2ao2SGgKZIRhgCW7uOLuquXHFfZVoC0nC1Yq99W0M/2cjCOd420ZYY69M
 38mXRCnzVLHRPsP+ug8Ne23XRd4p/sBq/bQufS+h2Fn/ANgJjxQFvNt/BQdaz6tzhVoT
 xEMVTtijLypchFYnuLgwkJmeKvWsbXrALM+PEYmdG/g6FPOv85fl62ZF9d1tZkD7B4Fd
 3rsK9K7gJ6joRACE0RCdUTI75Tv1i9LHkTHRokaSCAfPyccZ7sZrBY2tCIULy9Fidkcb
 IP65jP81RAINkO7Thj6+hCeiCxS2Hfa0KnpIA8cBRJJ8X7XjwST/SHorB6D+vXcV+PEG
 hZCQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032587; x=1791637387;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hQJ4RoG+mTPof9fejasIJ0C73P3MgaTENhk5o1AZO/o=;
 b=jiJ5NIpsNFrfU6YTt61iZEg1SFOmFRbFAlbI+D0utqj+ZIl2rgtrsQCWybW/pxFky6
 wrPrc9pyTkDfmGhctgcoKyYZWxTHWL/yjxR49jtUVsxhUTR006a5TWnG3vCsV/0byPxZ
 4s007gfNy8xKqh6GsNhKiURwkp5IcvM4NyDng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032587; x=1791637387;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hQJ4RoG+mTPof9fejasIJ0C73P3MgaTENhk5o1AZO/o=;
 b=fRgI/GLSfxTIbtz+22twjTLusVYHNA+ks9n0cR9ZOB/698HL20QdSsHZPfQXaTXjt9
 iwQsGZ2iULC2Fx3fIu2rjkwwpRAleTsS2Vt16vqnGrKtINcLP6uUwkckAJ8uiEHTWZco
 H/wM72bfqNrCxo9KpZGDZ20xjFO60KskMeAFLju5dqxJPI9uJ1w8SNAhBmOonP2MlxsK
 BO7ZBDy/1GoCJFIfuNgu6svQAUeMUd75pS3drCCkdwOyfOY1nM09Po/egaemdqNcyldR
 zJ4ahYwBNlzv+4w+2eIDHBb+F3Td/lcZtxDHPmcpcYBz0Z7dB0clp0C2mHb2VF5V2zkp
 F6uQ==
X-Gm-Message-State: AFq9FYLq6ryD/n3ZI7nb+0QCItXDKBaE1d1zoozzCYw+Et9022d6ihwQ
 Q+4CvqshCxBZGTvsyejG9mfk6zdwXBKJ16sSjmBBhYBlx+9GTSF/3A0a/YwugXWRclaYJYstufF
 gWYukqQ+EuMkXf112ZC0aeG0kljci9tq0VB1l0ojy
X-Gm-Gg: AYBFou318gH28UIcJQfl7CB6R3NiNLSScFJm/GJ+ZJXWkA3wBZVIph6r6NbAH3iG595
 D+o5MGdcVnd+naT85T9a93PAStEdypk/zzs1RyOsWyEEvfpEU/WzfK6Q0MYTv3tisfirLt5zOkD
 WvbHdI/QC1LhA8830yjmz/XsIMUzVAjEc/giBbBGlQothI9L6x2PecBY5zCrmM34tHup7AJ5lCL
 11q6+AUtN18IVZ1N2s3LTbfo2+hYKw8cnIDqBs9yage0YI1gNMCput7TMsM/bsE4HHhCT+et0Gk
 /o2s+QLtR32ESUTHY/27vF9e2TwyRydcRfqqXtSyIGfE2QrXWx88/qDOVmZgCoNpa+Y=
X-Received: by 2002:a05:6402:52d2:b0:6aa:ee54:9724 with SMTP id
 4fb4d7f45d1cf-6afad8eed6fmr2032382a12.16.1791032587065; Sat, 03 Oct 2026
 06:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
 <20260918-ufs-spl-boot-wlu-v2-3-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-3-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:02:52 +0100
X-Gm-Features: AclHuK-epfizH4yS_5_XYFVJJuu_jppAOVrvRQj21sIgpcIQlXFFhiaZvulCT4w
Message-ID: <CAFLszThPbnOMSLQMcznznYjLqvR_1cRYMn=6z4-5PEjhqnppeA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] scsi: size a well known unit from the unit it
 stands in for
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Alexey,

On 2026-09-18T06:35:41, Alexey Charkov <alchark@flipper.net> wrote:
> scsi: size a well known unit from the unit it stands in for
>
> A well known unit can read and write fine while refusing READ CAPACITY,
> because it presents another unit's medium rather than one of its own. The
> scan wrote such a unit off, since it has no geometry to build a block
> device from.
>
> Ask the controller which unit it currently presents and take the geometry
> from there, leaving the block device addressed by the well known unit so
> that the device keeps resolving where a request lands.
>
> Note that in cases where this matters (e.g. UFS boot W-LU) the physical
> underlying units should anyway have identical geometry to be usable in
> the UFS A/B boot scheme, so switching the active unit should not affect
> the geometry for real-world use.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> drivers/scsi/scsi-uclass.c | 10 ++++++++++
>  drivers/scsi/scsi.c        | 31 +++++++++++++++++++++++++------
>  include/scsi.h             | 25 +++++++++++++++++++++++++
>  3 files changed, 60 insertions(+), 6 deletions(-)

> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> @@ -50,6 +50,16 @@ int scsi_get_blk_by_uuid(const char *uuid,
> +int scsi_wlun_alias(struct udevice *dev, int lun)
> +{
> +     struct scsi_ops *ops = scsi_get_ops(dev);
> +
> +     if (!ops->wlun_alias)
> +             return -ENOSYS;
> +
> +     return ops->wlun_alias(dev, lun);
> +}

Since you are adding a new uclass operation you need a test for it.
The sandbox SCSI driver currently rejects any non-zero LUN, but it
could declare a well known unit which refuses READ CAPACITY and
implement wlun_alias() to point at LUN 0. Then test/dm/scsi.c can
check that the block device appears with the borrowed geometry. That
would cover the scan and lookup in the next two patches as well.

> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> @@ -511,7 +512,7 @@ static bool scsi_unit_attention(struct scsi_cmd *pccb)
> -static int scsi_detect_dev(struct udevice *dev, int target, int lun,
> +static int scsi_detect_dev(struct udevice *dev, int target, int lun, bool wlun,
>                          struct blk_desc *dev_desc)

Nothing passes true until the next patch, so the new path is dead code
here. Do you need this parameter at all? The driver already knows
which LUNs are well known (yours returns -ENOENT for anything other
than the boot W-LU), so you could call scsi_wlun_alias() whenever READ
CAPACITY fails and leave both function signatures alone. What do you
think?

> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> @@ -584,8 +585,25 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
> +             if (alias < 0) {
> +                     scsi_print_error(pccb);
> +                     return -EINVAL;
> +             }
> +
> +             pccb->lun = alias;
> +             err = scsi_read_capacity(dev, pccb, &capacity, &blksz);
> +             pccb->lun = lun;
> +             if (err) {
> +                     scsi_print_error(pccb);
> +                     return -EINVAL;
> +             }

The error path is duplicated and the comment about borrowing the
geometry sits above the failure check rather than the retry. How about
something like this:

    err = scsi_read_capacity(dev, pccb, &capacity, &blksz);
    if (err && wlun) {
        alias = scsi_wlun_alias(dev, lun);
        if (alias >= 0) {
            pccb->lun = alias;
            err = scsi_read_capacity(dev, pccb, &capacity, &blksz);
            pccb->lun = lun;
        }
    }
    if (err) {
        scsi_print_error(pccb);
        return -EINVAL;
    }

Also, the value from the driver is used as a LUN without any check. I
suspect it is worth rejecting anything >= max_lun so that a driver bug
cannot send a command to an arbitrary unit.

> diff --git a/include/scsi.h b/include/scsi.h
> @@ -296,6 +296,21 @@ struct scsi_ops {
> +      * can take the geometry from there. Which unit that is may change over
> +      * the life of the device, so it is resolved on each scan.

The block device keeps the size it got at scan time, so if the active
unit changes to one with a different size, the size is stale until the
next scan. The commit message covers this assumption, but please can
you mention it here too, since this is where a driver author will
look.

Regards,
Simon
