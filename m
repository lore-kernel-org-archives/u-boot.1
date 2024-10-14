Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5430BCF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291C088FF1;
	Mon, 14 Oct 2024 08:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SXyoZmf5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6824588FD6; Mon, 14 Oct 2024 08:56:34 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A71088FA0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43124843b04so16891695e9.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 23:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728888987; x=1729493787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Vqjjalkl1kKBqp8C+N+9xKFO0bLAhiifAPI3EGR0dA=;
 b=SXyoZmf51+yJMXC4EytgTinHEuWEneesZCx9bqaOyMtN92yVpXkE/UEt03BcZ855Gs
 otgAkKryRy/9qcD3N/UYSndupsxu9QzZ4qtABhf60P4nSr6SCnMRvwrD8rbb/FcXhtIr
 IusgT6xnxRUFiCPt93EFlXD087HnDodrUo9k30GSMT3oiUoU2ww4l8FoibZrXRZbIJyP
 82Pdf2423Ws7e5Kuq4a3Dd9a2EeDl6T7kNDVKyJERCmi2Sm35SCyl8BJJY6sZRsgn57H
 fbXPaGO/j+hpFkpLr5jlpCiD1NKe8dbQItVRmPEo4LEssU9qvtE6r2TA3jMB+7C2+CKJ
 plZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728888987; x=1729493787;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Vqjjalkl1kKBqp8C+N+9xKFO0bLAhiifAPI3EGR0dA=;
 b=gfVFXV+fJurKTt1jTVqG5miLqZ1U+gt+Q3xgHvZPauvzNUhySJfHpEuTHq+iISmi8v
 z6TKfPZwnKYFqXtIwBSn4NJMQwqMWAficRg1FHfPobNKJU6ffm6sDoznV99ATEZmkpVa
 x7UswEqkrfnA00qIeUe4kyzRrhFxHQcW8CIl/jK7aLNCqvFn6T9mPviZyyYQNBs6CjuV
 /AdLsgMAwNYkVluTSQUWxZ5xnK/bPPD9LTI4DWPpi8tFlFN1Zv4Dh+jVC4EJTIPpUYmB
 d7A3K7pWjBoXjDF4j9XjaMp9KimgmGogvnKTw32VpeJkPlgeQnOHtTNy8TaLUL7SDYim
 DlNQ==
X-Gm-Message-State: AOJu0YxYHG06ASSE+nkt39mB1a2KjYXkBVV2uPmediy9j6kJd3UL/osV
 2z+w2U92+xX7v6sjAxrtMmZr2saHvBf4WeKbui/vA3iBLilY5Elv2Qwn7WlyoPU=
X-Google-Smtp-Source: AGHT+IHcAqqpAd+CCArqlhB17gOayatq3Ue8VYaXX++Ep1F7Q4qMBR68/QNJMemUBiMpE4YngY/uDA==
X-Received: by 2002:a05:600c:1551:b0:42f:8515:e48c with SMTP id
 5b1f17b1804b1-4311deb6142mr91292595e9.3.1728888987418; 
 Sun, 13 Oct 2024 23:56:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d70b4331sm145900095e9.36.2024.10.13.23.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 23:56:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
Subject: Re: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
Message-Id: <172888898606.195460.7997216705941687470.b4-ty@linaro.org>
Date: Mon, 14 Oct 2024 08:56:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On Tue, 10 Sep 2024 11:20:17 +0200, Neil Armstrong wrote:
> This serie regroups all the fixes and base enhancements required to
> support the Qualcomm UFS controllers in U-Boot.
> 
> This syncs headers & defines from Linux, and includes 2 set of
> fixes that were sent separately:
> - ufs: core: remove link_startup_again logic
> - ufs: properly fix cache operations
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[01/13] ufs: allocate descriptors with size aligned with DMA_MINALIGN
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/9c223d8d8b8fbad667971f36eabe203480a8c39b
[02/13] ufs: fix dcache flush and invalidate range calculation
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/c64d22b57d8a9fe4d08ab677ba33d6004b98a468
[03/13] ufs: split flush and invalidate to only invalidate when required
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/4139e5680bcf3016561c8830d914ee0b0ab741d1
[04/13] ufs: use dcache helpers for scsi_cmd data and only invalidate if necessary
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/589a7bf0febbe4d3ca319569a55f21cf06e85424
[05/13] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/31f1615890b8c556d6f9d3c9cbed21378c782bcc
[06/13] ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/03c6f9b6bfe7bab5710a33b56486fb9defe8ef50
[07/13] ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/fdd33a7f140a2473277f9e365bc709f2cf425f0b
[08/13] ufs: Clear UECPA once due to LINERESET has happened during LINK_STARTUP
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/002afccdafdea6b6f0e4422e838649567b41e29d
[09/13] ufs: Sync possible UFS Quirks with Linux UFS driver
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/00c54af3addfc1475525396ec707c0c799010197
[10/13] ufs: Add missing memory barriers
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/5ce1a2c7de4936d19cbc0307be734aed9f8056a4
[11/13] ufs: Fix debug message in 'ufs_start'
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/966d3bf431273d8f397271026f0a6d488b3c87fc
[12/13] ufs: core: remove link_startup_again logic
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/67e291d147cd40c9b638515dc1bfa3c52d390959
[13/13] MAINTAINERS: Add myself to the list of UFS maintainers
        https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/fd6ce5a50d5b855559b9b7afc2dae73fd3f833c7

-- 
Neil

