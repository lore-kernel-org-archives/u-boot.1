Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD671606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iPNtcQUn;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pyIytqmF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E68440AE4;
	Wed, 11 Nov 2026 10:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nucXUVBKT5o6; Wed, 11 Nov 2026 10:22:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7799540B00
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392524;
	b=QWTDJ2X9kobeGMEyrLpFU4rzZrjWoZFZNkVML8hTWFM3JjL98IO8pyHVrGKo6uOqFYQt
	 idvcGmH4CRjhGr2qDf3SRs4UbYt/W9FPx/xCIIYcwwSfsLyny47eihP3BJYvWnYTJyuuJ
	 XPzQakYtL2uC5xmlDMZVhYqZZR1aRS9kKk520oP1S1PNj4vNjqxxvHT89VspKuNIZeCu4
	 ybrHdJBMSiNHfjj2pV7iQIX4a2MBHxRC34PFvnSZddjJY3ptsqBJMhuWtI9wNV9sCvoZq
	 kQ2lvVf8jxcSJa2dmj6CA2rvXxQoTyQex9ovq3hLhR09fenXtUyptrmocMVR6nuq27g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=97WQpLg1SqRqwdoj6EezUsulKx7hL+X/ExDKPRFERNg=;
	b=I7XHa5xcOdZ4cJXUwpUb2AiD3XPfrjAgbV/YpxkhrczthPi/dYkWNV5qeWDUIxyx79X5
	 7LzkokfOsIFk/0ZK1ukk040kOlOqSrYC28GGfOhs0FZeRYDp+IGBbOlPtX/tmlDoFXayo
	 Fk+1fq9wpdu+WkEFtM5winYkFXgLj+iL5flH5E+tDtKrhr6/Vuw39B1UCKB+OTGI9EibT
	 N7ScXjN++7TcWDoQEAwgwYHSWdMGc7r4DnUPohw7lvRHxvwbVvpEx8dFQRpnycMig34MX
	 ZlnUjVCJLK2+HpvKjAnkozoNVJOpBi6lW7f7ofSuMHOsO8MOs4QYB8mf6SSJepr+e3Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392524;
	bh=97WQpLg1SqRqwdoj6EezUsulKx7hL+X/ExDKPRFERNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iPNtcQUns5bhoQbKeN3SBkVpah40UMmq0TrRmOrQigWGD+/qP7lD4qQtC2ucO9Lt4
	 xGKbM1c/WBjASjvDKGGNkz3uqrmrlm0Kh9ZLM1v6TH8MK9lFSaW3eWyc6dZmnZrqsE
	 bk494s2NR+T6+aaNNqcxe0NzuoNNt7M6ydc3iiOuWAgc68AKNfSYJCnL29FRrFoXZ7
	 5eTOwdAf6jT74s9hj0GtXp0+jZS5CKc1iElW8eTHyZzEUK3iDPeXHjnplUSNh1eBj7
	 dLT6+bT727dXsD2vHrZzEwwfN83twyqhc40rtfr2VTvSfdLkoV5VxY2KzqeDgq9ZEo
	 Uhb6n8ilZ9Bzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7799540B00;
	Wed, 11 Nov 2026 10:22:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F6C2731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 563C540318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BALpy3JwDa0S for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6F38C40070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pyIytqmF
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F38C40070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:54 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-491846221ffso2112319f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794392513; x=1794997313;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=97WQpLg1SqRqwdoj6EezUsulKx7hL+X/ExDKPRFERNg=;
 b=pyIytqmFbRyb1J+jnDuj26JlahtfjFJrNf+X3+SpCJqbjmSSeiJHRfxOfEqBfCtT0i
 OE+M9dXH04lJEGwcZs+PsPoyC9rrkvIhQMXH+5zIoN8A3KQFwx0kS5eEA98ttYMhRpMd
 L9XFrEQxfqkbUiTr3XzfJUILg3Z4q06msiSeVdY8PRmFMq1S17guguyj6dLueqV4dd9N
 lOPGjQtUxGmA4uAJwSlj/qbjvN0xJvMBgLj4fm4YvQlJe7Fyed/s/Ui9CAnyACjd1TWc
 urkrk/YCE4ug5I/Afd6WTWJ+nnpXMhLMhAmnpJv6ep0eS7JFRyZCL02af1bdrZ4qf9yt
 Q/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392513; x=1794997313;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=97WQpLg1SqRqwdoj6EezUsulKx7hL+X/ExDKPRFERNg=;
 b=eKGJBnXN4nLhewaoHMCaBIWRDihDHOic/vfLjCMHwYB9ua+hfbcaXnhY3jH+k+4eIp
 F4oAztc/0Cc/sGcpRVfTo2cC5oZkURSgZmKmPUTKQLx0Mlnq6Psdl9MyDoHp3LOI01sk
 4JRy7vzqHPqNp3VGePp8PQ/IJ4JOZ+wDVAvSlcSVru9rDQwdmXvFu+2N7HSWfM6qUDy3
 vLqSvJ07Rs+WpfUuUDYDEa4PR1K+k9U9FVJ4eUym7jwsU7WUfhL/KYgKOKQbqep2aZPP
 yoIfgO2HqM3I+kh+2m/726DLUp6SujATVhk+n7XXzISk2XoNzijSR4kP0EK0jjNtcg9I
 BB6w==
X-Gm-Message-State: APuU4Z/Cr5x1ei6wQSspRd8N6lk3pgVHfkR92QouO+FdnfIg14ymp7J+
 uQ905wjZrVmM/wpV8+b+jsSOIa11I9no21fjwXpK0rxgGNFlUNlBrUu3IHsGJ4Nw3Ac=
X-Gm-Gg: AYBFou1zejshQPMoTbDLET/rCoRtfInm78oItINMu/nnGMntoIZ9+FDyM8J5NWBey7u
 aOn5Zr+e8/QSjGigu/AhBO3Klj9eyBvz6nmCFPeECnSNuu6H3oo0AAlMg1CkEomrywJkNu99LwV
 8Azc3JvZMiWvstgLsmQKpqze3gsLIDuaDiokcdgXoV01ZxEX6yMKpxiZFXmMEdXVbj/GCdggDQn
 xRd8gHhaG+LwpUs4elXXkNx1w/38rtjtqwysAQloTfub93M6DQGcEyvGI1Cx1wi3TnrdrjmOtaK
 oe3Cg17FPSf09jeRAeZJ6wU1ZUhfnqo01n9uzmJqrLwOpOI4VQcG9rHBmU8etRp4loYlv9PYcv2
 s2Vot1s5+k9ty7Ge8ubaUgnpvoLSaqC5lOOsunC3aQcs57GWm3TqdWgt0lnqbjySPaRYAyMSBef
 vXGQgnNixnE8YoGGIaQH6wlVgh1Cv56EMy3j0pedGabPDGq+sAmmo8Hl2EMPEEvbxIhBZU5HkRx
 8l/0CwYTturqL/qIM3Ukz8aRW0alOs99NKM03dKIvwFMYX5ASFZp+1ZvEbKKeO16ZNSlB1dwzfj
 dlQLNa/FLdY/c5Y+kNmqqRTD16LfnWJSDnFxOzc7+xiyhplgxpHfR+Au73dexQwVjB4QHYTXqei
 tJ/k9mxw2DTEmqiO1kFIGKRmpeId8wPAWzEJa2sibl33owA==
X-Received: by 2002:a05:6000:4917:b0:490:76de:c78c with SMTP id
 ffacd0b85a97d-499c6027c36mr2965755f8f.9.1794392512808; 
 Wed, 11 Nov 2026 02:21:52 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm10550001f8f.18.2026.11.11.02.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:21:52 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 11 Nov 2026 11:21:40 +0100
Subject: [PATCH 7/7] doc: uefi: mention UFS RPMB for OP-TEE variable
 storage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-genio720-ufs-rpmb-minimal-v1-7-701a62dfa034@baylibre.com>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot's OP-TEE supplicant can relay RPMB requests to a UFS device when
CONFIG_SUPPORT_UFS_RPMB is enabled, but the UEFI documentation still
names only the eMMC transport for OP-TEE-backed variables. Mention both
options.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 doc/develop/uefi/uefi.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..5dddfba32ca 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -214,10 +214,11 @@ CONFIG_EFI_MM_COMM_TEE=y.
 
 Tianocore EDK II's standalone management mode driver for variables can
 be linked to OP-TEE for this purpose. This module uses the Replay
-Protected Memory Block (RPMB) of an eMMC device for persisting
+Protected Memory Block (RPMB) of an eMMC or UFS device for persisting
 non-volatile variables. When calling the variable services via the
 OP-TEE API U-Boot's OP-TEE supplicant relays calls to the RPMB driver
-which has to be enabled via CONFIG_SUPPORT_EMMC_RPMB=y.
+which has to be enabled via CONFIG_SUPPORT_EMMC_RPMB=y for eMMC or
+CONFIG_SUPPORT_UFS_RPMB=y for UFS.
 
 EDK2 Build instructions
 ***********************

-- 
2.56.0

