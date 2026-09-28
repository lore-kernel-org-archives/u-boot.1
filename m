Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888FCCA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DDD58086C;
	Mon, 28 Sep 2026 15:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mkumf0l1Lgvf; Mon, 28 Sep 2026 15:12:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 793388085F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608346;
	b=FiBuEuI/6VCOaNzc2tm7HLdyZp6hbQbGOZKVWco9tODW7qzkLf9R4CM6OWhNDM2hAu3/
	 V9FJe/H0ME55LzTOUFqpxnKK19yGKbPchAHFEAcd43tGtzQL/swr1PNo0jPfKwQx7lXOd
	 NbVgI3Z+p6idUfBfjgdmfRVw1wWuGpSNArPcZ8SPMgQDNLiMcORfxswOvltIvC4XhYBhs
	 Qxwy05dXK9GtrOz/6Q9WdCylAPehErSZoH6VN9SFA6ZD3wktfRLm4CKiZO6Akk178127E
	 Uu5S2jFg1SrK2Ro8kh6tYShS2qsbnQ+3K1GoDP3YVvaQ0rQzN+VSbO5IWJBdGa7pCRw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4MZVrOsS1qDuAoJjem1SLKoiyxIXiWZLNkGwx02sBXA=;
	b=HUagkRbMZxtttae6FJAG5hiF6qs6L4DJo599J0qdBF21ztkYsOQq54YQaey8xBbEJ3CM
	 CWwI400nADWHEpjbz79dJw0bo5MQenD6W0ZMTd9UmCHnfg/h5OZeLnF0I+KX5aEjlO/S8
	 9ziPZraCNNI4338JQr2RSxMp9gfzdfa0jmdyLSqqAbUR85yQLxj4F95IzeVjoFWDKNYni
	 1ls6ZKlD0CvRjOOQI/HhAdfPdUPWU1C6BpsRSv1z7JpR7nDzp0C4vhq101jhFx/MBnOJ1
	 OD3whSXxsA8hu8pNx3uA8HidD7iUUiFJhg80zJt42nWka0loBzF8uQfOjslWtt/6ndg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608346;
	bh=4MZVrOsS1qDuAoJjem1SLKoiyxIXiWZLNkGwx02sBXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uXR9zvRxZ8LvOc6fMAppMoExwrMIrKf5tSlNMyq67yhxpDG02prtVrCRBsdlHwgQR
	 fQVXzjqdC3hesbLlfRWesn2p5gXxFEl+ulJKGKAPkOGFWO06fJeRXtn7DPh1DTw6ms
	 oOe9k3G4ZBJQAnI1nqnp040aiZIDf3Gm4lbyU/DkRNOsxtl38oMjifZBL7riT/XBoc
	 e/VMUU7vFUWmBK4oMYm5tSZ7KNi3YHvQpahhWDnWYHBcY6TeFbZ5wjZLa7EwF9rJpL
	 GQZ1OQ2YkDk58jxjBTY6QC59tjPudtpCAdRTDZZCL2GPO7GLDvAlQnnpz4DuuNS4hY
	 s7vOLD38uEPWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 793388085F;
	Mon, 28 Sep 2026 15:12:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B60624E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BD05401ED
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvgUSOwe-Ip7 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:12:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 721C740048
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608343;
 b=Sim/QOL4EKJqnyWJ5M4ltdI2tJXkgDxKm81vT1uHEE8veSWBaGxGKPV21aIIWhweC5Vk
 Dv7gstXYvowwN8/Kcc5En8LIVDK64QXhIQHNjgjfiziv1Oj3UP4AHMUidR3UFdjaxcyCi
 mva8Rd7e8yIzjaLaRVhX8DtzdoGCpm3ArlLbtHzy1rIxugvTurZ3K4nWxRiCO3amn804D
 n4C9KohsUW9OjwnpeXLMzeWkmioOoYoH5D17XdZxmwrJZdr6hVK1kSierNfJHMrf32buE
 b0GgfOCVGkQqZYA4FOmynGIQcXx+tPVkoh7Li18u9vN5e97CcNE2hIwXehkAZ3oc0MA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608343;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=4MZVrOsS1qDuAoJjem1SLKoiyxIXiWZLNkGwx02sBXA=;
 b=LsZrZRARSTPlpM88Gu60Y2qZ11E6SvKSsePWxFY47G4eT3LtJAjAt37nzfQLpdTUxyy8
 dVr6R4uEsAAwfZrrrH1rGr5f/HRYKOMzhNo/vb4pug5aL/yv+LvGvkVNKNwNawU6iTJYK
 B+boQGqoJ9hN6xUGX61Ka7tKkTyceQ7q5EFyjNpDi2FSE75Rg/BMkcaJ2XK79iBVPWDPn
 YftlUqHbCQAWeAsF6fhx9Fl5rmzR/zZGwZYScC+2b3v+bvgyqPc5mMPJYOEgMCLcFWvfw
 1qV+Ou6orveVs3QTjUOfWBKvzGXVNqBeXMl3HasY8/lV1Y/HI09CiBACbPJvgsiyWZg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="b0Td/Swk"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=b0Td/Swk
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 721C740048
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:22 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a996c8adf3so5096520a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608341; cv=none;
 d=google.com; s=arc-20260327;
 b=cfpXvNz4xOkfzCxHvMbdAjrYp3txbhSqergNlG9T8VNhCjEpCLQXY74jVOEF8/QNot
 kEQjeomJx6Gc2dGhUQMzojHzgbOadLgRKhmp8/nS5EHQqtbVDmPKK9wRoUBOS1A+oHqc
 hDqmX06EpxtaPF89y4ncF8VsgQDNvEqz+8peAByfkBqJ1ID17mlCw2nGgBftwq1ZTh82
 /Bf5hIuW2DIGVrj9zhp4p00UuHwWFXAnl2lTm4xBCOC+BrOXbEbfTyaUwBTT3wizxiI0
 UtUETFwDNI0MudpyedOrb3mu3MBNAZ5MA6SrqqzDtewwr0wjFFQtptJcyXtq8xXFGGeJ
 QPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4MZVrOsS1qDuAoJjem1SLKoiyxIXiWZLNkGwx02sBXA=;
 fh=0XIKztcrDCVA4/S6Qn0CcNOjo6QxhwuQUIu2oDcTMYA=;
 b=Fsv61k0L/i7x8tGhl6MTQyvZRPqU/rvyiz+YN7xGdenH9lG+GeYMCJcALASwkwFzJf
 k6qZKG/4G8V9qX8E+1accrWtVBlDx27Gf6U5Iw2fR3+Ekzd0dG6epG2G8ueSLJsmGM+e
 dZ1KMggzcocbFZwTiNVlqzGjV9sORvrKil1ZikziAXEYOMzcPqvIg6AHNu19ACX52cxa
 u5W4u/OXZpl1UvjcLhYH6ll7gsiPzgLmu1ROY/fHB7kP/BsM97wkayeRfFGgYmNuGa78
 Vy10kdrgto033yHByRUq1yNFYy8XuDn2KBBW3j4aqMXbj5wSHiTJ5JcYVA7ZnY48KcfH
 8HRw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608341; x=1791213141;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4MZVrOsS1qDuAoJjem1SLKoiyxIXiWZLNkGwx02sBXA=;
 b=b0Td/Swkpwa/IKypxLRQU8tiSiHptDjTgRjb9J6hNIfcWUdDbkdgFavR6waT311ifb
 dLNRRhtCSHnyQY0ItLoLxZ3Pc5iROKlB7fD98giEAz9VVIeKa9hljO7FYThnzIsNnf8m
 8J4pvnFI+1zeZHfo12bZijz479HiohgCn1RkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608341; x=1791213141;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4MZVrOsS1qDuAoJjem1SLKoiyxIXiWZLNkGwx02sBXA=;
 b=BiF3mPwwi/JH8WDHPROuQmzhrlnQg4oh0GX4A4YVYSqD/8ylgvLaNPy2UpZpFrQtxL
 G7nc1uKqHXQw705Ut0aszJEpDaeA4qHRGpSdpyln4ZiVeY+fy9XGhlktaF0ctlXHqTMP
 1E8r678UIZvE45aV1Q7A6V0AIx6WTiYULTeYc5jzSXhOcBF3SAekwu3QRPN46+WCcIjU
 iih1xKSGvF52Awy3Ok7znWErXVnKqpYcP0gsSAR1v09IBeMOHRgIvTFIjsbvfjIVwKwT
 ArugtU4yrYebV5hdG6Y1bksv+FaOgbGNplEbjiChYCekS6fRCFQmKWADKlkm9h763oQs
 OHVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDyQfA4hW+IHAkYrEP9Ilo4Zmqu4Oz9HOtpAzcCAAVF9A0jKjcP3J0mv7KgBwOKcBLqrvsfUo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJYPmiXmSkL+9dQubbSTeh/D8vbybbVNGN+dr50jsT+Lk8QRozx
 Ka9FOPwNGpepSCsSSXCYARyX+gO3yCK4iOXRPUO2YaORaBYFeuEpIkn1cd61gQIAS48aAtlOVul
 FTBqceXyGZppOp+4BFHyHTEL1OKaowI7eHaZpc/mn
X-Gm-Gg: AYBFou2N453e4FcWbwrPO40NY2jrhnp1wnXsF8YvGriFEm068dNvT/4cS3v7NJQ1JTJ
 FHeBsHCPZjuSU5jJaXClYrk/0lKOB4u80AoQj6Iu293o/7p1v8vuDQy+uymw3BZjP6jci8RB1dv
 ZH7oBqsvrJdozsxXj29BSTpiRUhnk+tDxKePNIBk7TfmNqeN5lmiLnh4Cm4uaCJG4uzxBjjnszI
 fCb28PUln6Ts3e0JsMX1degA0xnamzbASNDH/rLy85Ax3gwrKWMzJHkJTB/+a4S7xNihNRErMrn
 BqKCkqMOj4XYxV4OtdrYxHuDCho3jm0mIDpw6qG+ILowcFc5cbmLgQ==
X-Received: by 2002:a05:6402:a589:10b0:6ac:70ce:ba8 with SMTP id
 4fb4d7f45d1cf-6ac70ce0ddemr2256080a12.35.1790608340783; Mon, 28 Sep 2026
 08:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787272661.git.daniel@makrotopia.org>
 <84040f2872e5df8667841a526a07b4c702de8511.1787272661.git.daniel@makrotopia.org>
In-Reply-To: <84040f2872e5df8667841a526a07b4c702de8511.1787272661.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:12:08 -0600
X-Gm-Features: AclHuK-qom2avEcWYtnPK_JSjVM2eROdOBgzlNl1HVNzweInV5PeymfPkYtGFcE
Message-ID: <CAFLszTg8k21BrvaHqkaPxznuLkvpYpW-xZxa5qLZU8BB6u+RxA@mail.gmail.com>
Subject: Re: [PATCH 1/9] mtd: bind an mtd_blk device for non-NAND MTD masters
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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

Hi Daniel,

On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:
> mtd: bind an mtd_blk device for non-NAND MTD masters
>
> Only the SPI-NAND bind path currently creates an mtd_blk block device,
> so a bare NOR (parallel NOR, SPI-NOR, ...) has no block-device access
> at all. Bind an mtd_blk device for every non-NAND MTD master when
> CONFIG_MTD_BLOCK is enabled, so its partitions become reachable
> through the block layer (and thus by bootstd, imagemap, ...).
>
> NAND is excluded on purpose: it needs UBI, which brings its own block
> device. Partitions inherit the master's block device via the "mtd"
> partition type, so only masters are bound.
>
> mtd_bind() keeps a pointer to the passed mtd_info pointer (SPI-NAND
> fills it after bind), so the generic caller provides a small heap slot
> that lives as long as the block device; an MTD master is never removed
> in practice.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> drivers/mtd/mtdcore.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> @@ -494,6 +494,30 @@ int add_mtd_device(struct mtd_info *mtd)
> +             struct mtd_info **mtdp = kmalloc(sizeof(*mtdp), GFP_KERNEL);
> +
> +             if (mtdp) {
> +                     *mtdp = mtd;
> +                     mtd_bind(mtd->dev, mtdp);
> +             }

Two issues. The return value from mtd_bind() is dropped, so on failure
mtdp is leaked (mtd_bind() only pr_err()s and returns; it doesn't free
what was passed in). And if kmalloc() returns NULL the block device is
silently not created, with no hint why partitions are unreachable.
Please log a warning in both paths and free mtdp on the mtd_bind()
failure path.

> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> @@ -494,6 +494,30 @@ int add_mtd_device(struct mtd_info *mtd)
> +              * mtd_bind() keeps a pointer to the passed mtd_info pointer, so
> +              * it needs storage that lives as long as the block device; the
> +              * MTD master is never removed in practice, so a small heap slot
> +              * is fine.
> +              */

The pointer-to-pointer indirection only exists because SPI-NAND fills
its mtd in after bind. Every other caller (including this one) already
knows the mtd, so the heap slot is pure overhead and, as the comment
concedes, leaks if the master is ever removed. Since you're touching
this path anyway, how about a second helper (say
mtd_bind_master(struct udevice *, struct mtd_info *)) that stashes the
mtd pointer itself, and leave the double-indirection variant to the
one caller that needs it. What do you think?

Regards,
Simon
