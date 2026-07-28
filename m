Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FB8C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C505A4089C;
	Tue, 28 Jul 2026 06:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V94pcOOmJ8pt; Tue, 28 Jul 2026 06:54:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A55940893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221645;
	bh=eUCpoQit3CjVddwW0hT84x3F1pTnaGzUKUi9wt+eC5M=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GxhFSc8r7C/fBKwtzLEDXLNv650emZI1nD4b1EviLVfNcwKrH3b0VioA0M8n/0ug7
	 F+9tgerFOYCAyevf4yotU0Qg8XR0wNDbnnCdBtP1rNvSFQtcsA6yvZALZg3UdZ7Hrb
	 23KXlrUfAIl2vmr7sfkzo9XH4jjMTlDcxd2TicxeQECRU5tGLrEUfmtNLA65yvYb5Y
	 taIREqbT1p+Ji2U/qJ0/Y2Wr4cNLeiZHDZ4q+UU3a89yyoqY6HUpFGkWPjX66UTA0t
	 H4io4bgbgE8Gz5r7f4q0A+F8R1EklcbAErR56ii/A/Kg6W2EHdPuVyAW29ANUou49I
	 IAGgIaTjSZRHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A55940893;
	Tue, 28 Jul 2026 06:54:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A9B8357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 710A181264
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ELlucsVRk_Dh for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:54:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8B9E681263
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B9E681263
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B9E681263
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:54:02 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69f734cd461so393307a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221640; x=1785826440;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eUCpoQit3CjVddwW0hT84x3F1pTnaGzUKUi9wt+eC5M=;
 b=enGubNuWZFnvzli63n1pJQZ00tg5Ee37xKbOgUISxv5QQxHhATA/sPfAEZfUf2U/+D
 bpRAv37uJfRI5Ez/bigqAhKlmykumfcbw8bGQ1A1EiMA1PsmrqaOb9oGdt3Xgo4HgM2c
 vumUs9/UnKs5zBnhZyt5HlUME4ddnd118PsxxRZUeCGpLnGyuNzSqCgIBFqs1M/Cr6k5
 2nEp33Uz/kAkwY9avJqftxQO+oP75VuLCc64T+8Dp67a+6VcyLmY4YdR/Vg0gmq8cTHd
 q9DehnjbSlbDmWUYOzmEH0/0zV83bGzwdjm7Tazj8fPolZkHHZSDNtdtOhlkDnxrz7x1
 kYTw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8ePqCrm4qNlN/0i/i0MEujpYT6xSGq5C8QVOCHrhmlTE0TlOFAfDqAKltppUfdhkZufQw2+8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxnYqfPv1ZGoy4KCEKd09lAzmcMPF78G+jrhtmG+DZFJ4rX0KF2
 +qbcgjaW0zgVntxwfFAdSkFtDp2+BbSzqukbyQkbaxFMnuxwgkITJ+hY
X-Gm-Gg: AR+sD10M/43gT0k0ROtu3XkFMUcXz42gCeOBXEXRMbSf4nXyqafeZMzXKu3rEtmQw22
 xLXvuDFESNrs8hgtGT6g4kOtnsuElA6DJgTPMeSlt9i5RGlYO0rIrV2/JaCVsc6Fa0wMUA2qaa/
 IoIV7XTA7wzG5BghB5Qtp1LZGmOVQLuEoYvoDPmWqTDm3PEfVV1dnGnNG/2OnUi0v6Zk+5l9Ant
 LBxrXRjnExxDBsHkshmZbrLpUBsbo+YpffFR+uhy0vIogg7JbIR0N1Z4Q7mmQToEx29x4hO8HWD
 R64c/dhnEARCMFfe9mFwrqFTWwbBRkoz6lqbMts1AxQ5onLdGrT5qeQ5VjCY9/rvObV/ihDeAvj
 /nwI4Dx4mzhqoU9fQunuI3aBxnal/rk5arikdDD0ZbPxZrr7IsMDbCIUoBQ0Sp4W8AKtc/NVLPy
 vl1pNamtECplFDzNQJkLwUAkLRnTZ15ZgyZW8EQkce
X-Received: by 2002:a05:6402:4585:b0:6a0:eb:ae4b with SMTP id
 4fb4d7f45d1cf-6a0349411a4mr288107a12.0.1785221639961; 
 Mon, 27 Jul 2026 23:53:59 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5746e08sm3491703a12.23.2026.07.27.23.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:53:58 -0700 (PDT)
Message-ID: <e6548232-326a-457d-b207-194af4ec5bd2@gmail.com>
Date: Tue, 28 Jul 2026 08:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 02/11] rockchip: doc: change TPL phrase
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221640; x=1785826440;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eUCpoQit3CjVddwW0hT84x3F1pTnaGzUKUi9wt+eC5M=;
 b=I67EyPxCcObeaKgYAGlbJVvQlFzQFOTuPhSMuC3WGN03cEUm/rOkOTq0sV2N+WMdbj
 D2ZQadEzHVNmriIc38keqbTDjlBqeCDFb/I9oPoDG/3ySZ07mHmXZWEGNOInff3+7Glb
 CmpXns31AyTHRudAiV5yfnBo0/NRMTkg0/6sAQVfhIcEz8HEwWq/qyisc+2gNn5sFnQh
 mXUcw8KiCwO8YoRkQpcDcatSRAwiL1oH7p+vxfSN4iD61ZGIXoUdJqZyE2MN1QswRLYm
 yd7WkojpHBkBqt+XJD4ZCu9RI4vTY8OO5N3UYthUEp23KSSvrZC4g//tPQ9vLxWoZ/dw
 EExg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=I67EyPxC
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

The TPL phrase in rockchip.rst has some spelling and logical
problems. Rewrite and add missing structure by changing to a
list view to better separate the 2 choices the user has to make.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/board/rockchip/rockchip.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9351a5b8eae7..718d5c6f25ba 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -219,9 +219,11 @@ For SoCs whose TF-A code is not available as open source, use BL31 binary provid
 TPL
 ^^^

-For some SoCs U-Boot sources lack of support to inizialize DRAM.
-In these cases, to get a fully functional image following :ref:`PackageWithTPLandSPL`, use DDR binary provided by Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot.
-Otherwise, follow :ref:`PackageWithRockchipMiniloader`.
+* For SoCs with U-Boot sources to initialize DRAM follow
+  :ref:`PackageWithTPLandSPL`.
+* For SoCs without U-Boot sources to initialize DRAM use the DDR binary provided
+  by the Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot follow
+  :ref:`PackageWithRockchipMiniloader`.

 U-Boot
 ^^^^^^
--
2.39.5

