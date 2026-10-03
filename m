Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF9FCA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4DF441417;
	Sat,  3 Oct 2026 13:04:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ee3Ys4OETEWd; Sat,  3 Oct 2026 13:04:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 09C2341407
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032685;
	b=Q7XCeZSQHGfiuwBtcZK4e9ATwy0GzikvaxDJiIdKStUvJa357qsMf8IbuPQx/tN1M5DN
	 xqDM1LfSDBwstYte+IQ9+FgeG5iD4C9LZ3mGY7YBV+S+yYAL1muFMQygCxQiFntsp0fvs
	 rfVFUU+DzEE9HYBF5atiQP1FtQSLra8PbqCvHKHZvK7TzMnSidG00p2ui8N9Tnr6xZ6M7
	 X+otoNq144yt/2szOiMIbUjOcrjxmdwKFEjANeaO+7RV36o3sQv+Ke+VcFBVCebf0VNMa
	 AfXM6poKxYT7JBlSc43FwFSaO4PBorveePRnB5k8ZzppM6Yhfw9J1q1qimR5Td7OneA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y5ZWrBXsSP9raICHpqrkPliHTEUhG4swAfjU/M0mHr8=;
	b=hcNszNPifizLamavNpvFFXWIxaR1hE3/WqpzO3b5J5E8Yn7m3IvJMwxaH5+2tDsQD4iG
	 ygRUnzsDGaygK+H7wXTv3SVWXt3vrohv7dRmAiqE67Nm6g0Cw7jEfNR56YyVA0FEfUivP
	 zrnr+uQWaCHUgLp2gQdkbkkSFcfaShsw5uymwrwWXVC7tokamI2i0+VXuRZ1CVHsDU4NE
	 J8+UPdyNl1lcn/gWo8iJCsR6JCXy5YdE/o9aNl7VtDNZXJz84uPM1TNrBUeT5r4zvmdKm
	 eUftsBGmyg6RxuTSCSPaJWWgyePkZ/p0EqpSv13+xvITF8mpO3n6XtQ602chBcPMBRQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032685;
	bh=Y5ZWrBXsSP9raICHpqrkPliHTEUhG4swAfjU/M0mHr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aUMcbuKgMJin4tsqEVRaIbI9Y1u5Rq4AnzO1AlqFzR1OqZ/Nv3WiXxg8JWkeL9He7
	 LnvbLPuwyEDbZSVmA6AHmfvi3hsgeeDWuMxVlEJJfdHEhLLcLLPISiaeN59pYx3Xb9
	 qABaVluHIvCqZxCNk5Yp7rKTwC1b5syl8ytcxl4NiSZgxqC97p+ItzWrKpNUHPcDy/
	 um9FX4NwgXKy3NhIrt/0RUv7+Vkn3DOutnovZamAq2QcwCjirEyvLdk1w5DRmNFxuC
	 KkJ+cM+QYg0f1MO2qqDSuVZr8OBMM+tZyFXixh2VDZa2dI+/+hgqUu3NkMgAm3IzQ+
	 QgyJg4WaWzt8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09C2341407;
	Sat,  3 Oct 2026 13:04:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D4112435
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9E9940063
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFXVBO9u4syy for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:04:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B70F540024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032683;
 b=KXxyLHtTf/cM27a91GUlGL/e3q8aj0GE+EXFBYZDZL15quXGnXryJ4YZs0QP9EIPDCfM
 9y6UNMxxv/Mw6FzUzg5XUxiNzx3kodKmFiz56bcYtH3bzvtq0vtmgGOb4rVahgfOCsrWB
 uaIpERi9IBBO7KD+vvBBwYjF0DfysVRj1iuQym1O/zGY0Hg6Nip6A0+cmaKl7W5T4gmP0
 FhAgv4VMG0vdyERXu+bIT3cTUSwjD/kSgIkHCNifLrYcy5xE01ZERjeKgqCg2qk3YX4Tt
 wHvjNTMDW61D8HdGvMdaSSPouzQrzUHNlUVgrv2+prjbBhcHrBDsA+hzc6oHgMb2/ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032683;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Y5ZWrBXsSP9raICHpqrkPliHTEUhG4swAfjU/M0mHr8=;
 b=bJNYCtEQJzmt/GB/o/j5z+usUfNT6Kwr5BaHnruVpvD74gLD/IDX4qJR36jf7OeljEZc
 Gi0ySMOzpyHk4txkGuBunFOOjgA1q18P2Fw/NWv4B/vv44CUqfttB3eY9Qooza/0lSjkw
 LoDVJhrSmWv9wD6tjQBrdRBKopd2NI5levmeTG73OZnHO7cTaz50le4udMfgJJEXxglWP
 SA9zx2QhzEAPKK628If/v9niC5EydH3G5JmTMMAbD/NNfy3QxUfqtUwPmzk3uVpo5dgrJ
 n1snGNUhy3kOcNdD73hwgU2CtSgCa6p874zQFNWlHOS/7uN1LWDM9Z5Hd2weRjNrAWw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lihUi+Ty; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=lihUi+Ty
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B70F540024
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:42 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so541156a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032681; cv=none;
 d=google.com; s=arc-20260327;
 b=h3QtI/JDoC38dxSZhjUqWckpAbt7Kf/d+ORl9e6sEtFAsHBUMwJsGye2WER1UTUjN/
 3ClmTtzlB4EntR8HeGuHJyFN2ERxw+KCFJ6MTNVnshmPGCctoTtj7B7VSG1MFGZJ738Q
 Ryjz8vcxt0lD7xazTVQE7YGEt5+UyKTtPgwAj0iGxD8+PEGCRKN65IJRHjTYCjaAUb73
 fe/3cqFyZtmDNQf/LUJfpk8EJOXUdqcoKGAaOjzIjLmNlvqx18u++77Ya5ZWMmKY/E8H
 PGIu+n48HigdhrxGlf4rj8JW7ITzINOQ0Gcs17NxxsLJkHoF36dU+rsONL3m+vnJoJZ/
 d24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y5ZWrBXsSP9raICHpqrkPliHTEUhG4swAfjU/M0mHr8=;
 fh=BEoPNN0ojtgxNz8fjZSoyMObtb+XDDU+qZjnWDTAHBk=;
 b=KwRK3kk8YSi3DkqexPFOdGBUY9BHVzj3VMPfDwkPSCpvTM8ukGtnf2MIX1sJZsXdxk
 aawLIRkHjjwBHc+iNyO/lAkMnVTwu0GfeyEs67C30l6AfGMqhIczJxyZfhUWP2ZJ8wOO
 1YdONtw9M2N2FlUUpLzR8tozDL5jsNWnF2sz47lcAwf8SzHOJIS0N0wcB0S2gf84sUoi
 mEwiUY/kbBCLdaZ19cm8a2ojzPJbiHSNLJwMUHFa4HH8qKwCWopsmZJO8XVnvbNAYvta
 WtTdGw5egKktz42BSoioMX3ywoOUw7efMC6qDYM8oOs2jSuJ6b0a3J6VbhzOfMLiuOqL
 0IWQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032681; x=1791637481;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y5ZWrBXsSP9raICHpqrkPliHTEUhG4swAfjU/M0mHr8=;
 b=lihUi+TyK5N0v5H5mQTwaP6d2wkGjh5ukPfv58XZeV0fPiTu9W9E/MGN74/h46QfaN
 17QMTDDqZM5pwPpQQch1PkRvYeKoDQp79+95oVUhKmvdGUT0vgtbHcEga7kstkne9AGb
 IIq7cV45k8C7LRHPTP2DBKhhbKiVJFCWLOI0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032681; x=1791637481;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y5ZWrBXsSP9raICHpqrkPliHTEUhG4swAfjU/M0mHr8=;
 b=qmOTPNO2NGFcvcfpSlKxTTscKcfq+MeaxuWkq/gHb/WwdYOwCvzEl2rvlandHrPR4W
 R6G9lu6m82dOn7brYEF57dRcOfnWPdeZ4LLlEM/n8prVfjJj2g/+kJWBkxAmlu0Awqn+
 so68eafNHEfMF01sIaWtYqP10km6WCaojH5VmXkYFTFui92lenl5jUSI6/biY9GucW/l
 nnw8Vv6EHNUpQ8RsJW9onDi7p/xjwOmacngHY9fsz+frcrcNMuT+Gt5qHNxumRjT9+13
 aSpVdi7cxkTeVKtevU7P1ok5LQpdg75pZBBa1MuGncc0FSphtE2CBE8z18yFWTU1sash
 3M0Q==
X-Gm-Message-State: AFq9FYLDgAu+yrpnu/qt1nw5B9ltxLxOmW9q47xLB6T8EUdiO7LPSjsd
 XJ5C2Scx+y/8Swa6nm0ECw2l+b0EolRNe7YPoBlAlBh32lHSEK3PZT6KmhgOd61T4JRvNMnRYau
 xGxImmru4bBQ3ulTz4qEnkn3Nv2FyaCD9lAwtChc8
X-Gm-Gg: AYBFou0AJPFC7YPUq6S7y2rFT1CAw4WKe+zq9f0imXyy1lQAegjqJrhZ+XLn3Hp8STo
 4QmZ0wIUOZ9tX3+24WBRBuHK02dx/oNoeoqOgZo4lBhln/SGSTGVMLYSSqgm6AXIwSdRqWKK5IT
 ZMLR3nwvDusuUqQpQUVVQ1JmLnn2+4X7jrRv/5mdOhmyBCryB1jkAfFeVtHFIdGUHSfkVah1mBo
 R9niK/aQ5HhMHue3tCSBIJGyHeJt+SWKsM0KWTEt0Mh2Jv2499uT7l1Z+V4nMs/kK45iH3ypwKz
 T2qEkjMziwet6ofxeGrUh64isRur/MVVQfc2rGWscI//RB2WieRCREKA
X-Received: by 2002:a05:6402:43cf:b0:6af:9de2:b1f5 with SMTP id
 4fb4d7f45d1cf-6afad8d0a0dmr2105179a12.12.1791032680656; Sat, 03 Oct 2026
 06:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
 <20260918-ufs-spl-boot-wlu-v2-5-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-5-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:04:24 +0100
X-Gm-Features: AclHuK88KhTyg2sIdcBfZYJS4b-CKFw5guXkoDTVb6Hzs6HFoz08eG-ahRxJZD4
Message-ID: <CAFLszTg9fEk8ViVucBzv+Oj38gG8-gR2qf5y7LVcuWHT1Z_59Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] scsi: add a lookup by target and LUN
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
> scsi: add a lookup by target and LUN
>
> SCSI device numbers are handed out in scan order, so a caller has no
> general way to request a particular logical unit without relying on
> assumptions on the scan order. Well known units make this worse, since
> they are probed after a range whose population varies from device to
> device, even though their numbers are by definition well known.
>
> Add a helper to unambiguously look up the block device number for a given
> SCSI target number and LUN.

This is only unambiguous if there is a single SCSI controller. Device
numbers are shared across all of UCLASS_SCSI, so with two UFS hosts
(or UFS plus AHCI) the same target/LUN pair appears more than once and
this returns whichever was scanned first. Also, the helper provides
the blk descriptor rather than the device number. Please can you
update the commit message to match what the function does.

>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> drivers/scsi/scsi-uclass.c | 19 +++++++++++++++++++
>  include/scsi.h             | 16 ++++++++++++++++
>  2 files changed, 35 insertions(+)

> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> @@ -50,6 +50,25 @@ int scsi_get_blk_by_uuid(const char *uuid,
> +int scsi_get_blk_by_lun(int target, int lun, struct blk_desc **blk_desc_ptr)
> +{
> +     struct blk_desc *blk;
> +     int i, ret;
> +
> +     for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
> +             ret = blk_get_desc(UCLASS_SCSI, i, &blk);
> +             if (ret)
> +                     continue;

I suspect this should take the SCSI controller as its first argument,
since the target and LUN only mean something relative to a bus. The
block devices are children of the controller (see do_scsi_scan_one()),
so the lookup becomes something like:

    device_foreach_child(blk, dev) {
        struct blk_desc *desc;

        if (device_get_uclass_id(blk) != UCLASS_BLK)
            continue;
        desc = dev_get_uclass_plat(blk);
        if (desc->target == target && desc->lun == lun) {
            ...

That also avoids calling blk_find_max_devnum() on every iteration and
walking the whole BLK uclass again in blk_get_desc() for each device
number. I see this is copied from scsi_get_blk_by_uuid() but it is not
a great pattern to repeat.

The caller in the SPL patch would then need to find the controller,
which is a bit more work, but it does make it clear which UFS device
is being booted. What do you think?

> diff --git a/include/scsi.h b/include/scsi.h
> @@ -395,6 +395,22 @@ int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
> + * @target:          Target id the unit sits on
> + * @lun:             Logical unit number to look for
> + * @blk_desc_ptr:    Provides the blk descriptor
> + * Return: 0 if OK, -ve on error

Please can you mention -ENODEV here, for when no unit matches, since
that is the only error returned.

Please can you also add a test for this function in test/dm/scsi.c?
The sandbox controller has two targets and three LUNs, so it should be
easy to check a unit which is present and one which is not.

Regards,
Simon
