Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A59C5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE7DD4078E;
	Tue, 11 Aug 2026 23:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UAHFH38vtac8; Tue, 11 Aug 2026 23:01:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 032B34075D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786489318;
	bh=wFRJDUGi/Ep2+PNHxuwM1I1msOzFW24yLF7UkTwgsxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N+ySMvrFgm90oJTn4vjwK047S7OSIVky5RfCLf6MlqyNKHyo9zwyMyCEUjVfQQKcE
	 wV6wLrI/lUYy27Ns/r93fxz9qWgSz4oHJWKyFWrFRS6kHhEulkSthP5mexekAd1hPk
	 /V/gqwZTDLNytbQV1WaiUadtKX2GEUlv7N91akZxGC3nw938oP6+hYHSLz1UeD0DtQ
	 2N4b6bgj4MfdpWFk7NktH8q6FEXUqaitIqPVRlSc1QldI+iZSrq8S+ZErtVb6ayTF6
	 NIZsBxmb6SjqlWEK+o6NzGxyjTbrpnkYXnTiwwF4DIwbYeC4HnQfKpGusbSSxpF7pX
	 k1x6tPenlCVRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 032B34075D;
	Tue, 11 Aug 2026 23:01:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 700D32E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 568BF80F4F
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:01:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhxQAW9HecB4 for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 23:01:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 637DA810DA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 637DA810DA
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 637DA810DA
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:01:55 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5b011edaf7dso281013e87.2
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786489313; cv=none;
 d=google.com; s=arc-20260327;
 b=VPdU2pU9CrR9h9H+0KEpleDJDnswngjo6rUAOao9St1JeEmceebpmN17Eub3dba2So
 LaNyLRGtas1HMrX1L4S/3gHKLsT2Ra85WRgAR9e9D1Eo5XZWGAs4HsTWU+0pcbZmnG/b
 kIhLBlP91ZNc8xh9On3avv/vWk1FeTxp3s4Jmz2xmuDS1HpHNmEvwFpDMa3EBLeVsFOh
 wpQ6s1r1X6jnLlcoqO4SycYc64VzaF0Nppa6fSRmveeQSn+KaF7cup9XUeiEsruz2PlR
 SRvtYVjXVCrJLf5Uf9qSqkL7swv5VccjJFb4DxNxX7ocED9DNWSeNfxztvLWw+Ddv4Bl
 9oXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wFRJDUGi/Ep2+PNHxuwM1I1msOzFW24yLF7UkTwgsxk=;
 fh=qs7/J8g0rc/jeDy3+gcknWiEQRMnsEzMG92J/Rs1wO4=;
 b=NV9TjlWhXk7Z/YDrUSpVcBWkeU+biU/6dAXplgBOqvTr0k+DstqqsreDyoUfh8RbgN
 5HwUloMWIgBFZzQ4UowjJc65uga5YHC7SSuOkGv9VqnmWRHHSeMQFxjP3S/KcYSSYXYY
 8LrG4Nv1Nkv3GdCbwor5gPBOILq8pURhKZ3gfLu3EXZ4vPQ6X3XTn2TTXdQ7PEOjDXbt
 mx1jTHooqeim9LU5A6g3TOAa6cs3LTje/jgh1i1T8I1PYnnXRpFVXFHLr7nSF1CikhMv
 Z48shgLcl8iz2wu9Nu8DWhrgO6ZBnN6H7ksSVCYDKT7XtRrCUiBjxyRQ/aJhAWtga+YC
 uqoQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786489313; x=1787094113;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wFRJDUGi/Ep2+PNHxuwM1I1msOzFW24yLF7UkTwgsxk=;
 b=V4N8JkL9+Kf9mMoDaz2juUotLVn4kNUQeMFJPA5g//PItaP00tGgRGB8qdzAxDfxTq
 AoUstPVhIJusxShVG4ZlbHvNFoP0jEgfPAYUaE6az2Y7DQHdGlgpGqPtHqzxxHIipUOS
 8WbwE3PPp2L+IsZWx3woXJyk2HfEDb4hxw3zrdKu17acAvc+XBftRVH2F1c9S4KorSWq
 6QEXzagKDH47aSgrFT7R+KNh2iQwQraBqi3HgwCoWdtTl784FceIZRhZi4h2aRD0JRXZ
 I9drSbFi1hW1lbinjlDsWiWD0xk0ZrneGN2hqSzXRjb4AK4vriFqH49BCh/oHzBngUNW
 xd2A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrnkz1plqF9+r58o2pgubC8dhKz4CfQfOOiO3ZbkTebnIrEkuwfCCGXZnUELX5krYHUvAtQtVw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx+Nla5gf6BhRTM4O++4DcpLPfqPgkrb6EROA42dcLxzLbs3tv+
 3qXdDOruyu+IYhp1VcIdtJBFT/cv6vnSbaS8zu9pnSXqBYAaH/SJ6ZyMV0kH0tsPwalaM6nk4yj
 vouWPTijGQ/S6E/F7r9f8YxfaQxR0J48=
X-Gm-Gg: AR+sD10S1JEehAJhSQ9envNIf+2GFjdinMxttDU/iB8mMQ0dCIudmozPXo2wg97ZLvD
 BTCK6Wn9+Y0D/IiEpbxT3uYWhq7hTNid2ijB06dkbOBQw7GfFZrI+KluZYOvlRgV27F/6QKDot+
 EyIzEIj29FlM2F41ucOMaC7EKmib3Dn13NuNCJrWKIx2fd3HNET4TtoVC50qv+qgQWL4P6ScFsM
 NrxAqnqTE5SUTacTx6Bkyfxp95xcKanElzLXnOOLgElf8OOgXYmEbsNNFGRVn9ZpkfK/Nytx2So
 lIW3R96n7nZVpuzvMU5KH/XU3I14BVHGlVpOckd4itlfqneOYJHOD+LyCLu8rn4XZLq9vl9OOCv
 thOkO6PCZJ1lOiA+Yg/6cVOuTkBmptvw+
X-Received: by 2002:a05:6512:2315:b0:5b2:1de0:5e7c with SMTP id
 2adb3069b0e04-5b44e32fd5bmr106292e87.51.1786489312634; Tue, 11 Aug 2026
 16:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260722194638.1285159-1-festevam@gmail.com>
 <20260722194638.1285159-3-festevam@gmail.com>
 <d4d49e17-e125-4121-b0be-e486e1be5393@0leil.net>
In-Reply-To: <d4d49e17-e125-4121-b0be-e486e1be5393@0leil.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Aug 2026 20:01:41 -0300
X-Gm-Features: AUfX_my1HwgMiGGULoLXpNUYV49be9jSm8cmn7Us5xmm5GjItvlX0A9g1EIgt-I
Message-ID: <CAOMZO5DULY0wE_U-4aX9sfrnum++J9iJ02_H8L+g3qdY156KCA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
To: Quentin Schulz <u-boot@0leil.net>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com, 
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786489313; x=1787094113;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wFRJDUGi/Ep2+PNHxuwM1I1msOzFW24yLF7UkTwgsxk=;
 b=TgzLxS09WDxulGwXauxwaKX4egPBuLQJVxsCliORVI9Qmc2EoprmZrzQKhaQZn4OpL
 WWDhKgeQ2vOcw56QtXl7KLnOb1P2N3BsZzzzV8gRwFBgbuJdOkO8jaHGvzbcDz7iG1ia
 M9DAPAc5CKunDFV+A2lYaA0QCfYHaOuI6uD9b1I5ACptaYC8e0y2RcbwxWvRHM+i7cpB
 TmSWFfTNW9+OitdN55y9mly0xd6YqNz/kuNchArphb3hMYpiz8Eu1ZrOmyQh/wwpv+14
 LYeCfqPotvPqK5C4PjtqwuRUUllX+uEgqWmjtk8SmgoMKBU4VO+z7bPWB96pEqfJ0YO1
 eZrw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=TgzLxS09
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On Tue, Aug 11, 2026 at 8:55=E2=80=AFAM Quentin Schulz <u-boot@0leil.net> w=
rote:

> Ideally, we should be able to automatically detect whether it's a
> roc-pc-mezzanine-rk3399, but I couldn't find schematics for it and from
> the Device Tree, there doesn't seem to be something we could use to
> detect it like we do for ROC-PC-PLUS/ROC-PC. So instead I recommend to
> check for CONFIG_IS_ENABLED(DM_I2C). If it ever gets enabled for
> roc-pc-mezzanine-rk3399_defconfig, the logic will return that it's NOT a
> ROC-PC-PLUS and thus use CONFIG_DEFAULT_FDT_FILE which is
> rockchip/rk3399-roc-pc-mezzanine.dtb which is correct.

DM_I2C is also selected by roc-pc-mezzanine-rk3399_defconfig.

We can use SPL_I2C to distinguish, like this:

--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -68,6 +68,9 @@ static bool is_roc_pc_plus(void)
 {
        struct udevice *bus, *dev;

+       /* roc-pc-mezzanine-rk3399_defconfig does not select SPL_I2C */
+       if (!CONFIG_IS_ENABLED(SPL_I2C))
+               return false;
        if (uclass_get_device_by_name(UCLASS_I2C, ROC_PC_MP8859_BUS, &bus))
                return false;

If you agree, I'll send a v5 with the change above included.

Thanks
