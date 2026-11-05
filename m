Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E5A606A328
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c6ELb/jz;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=B2TrYnIU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B10281200;
	Thu,  5 Nov 2026 23:46:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GxxElPEsRbOg; Thu,  5 Nov 2026 23:46:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BDE4F81201
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793922403;
	b=T5GEwrzRaekJqekB6iyKBE+jgWFuMHjHrun46eiTznL3zE0fhJuMjU8Sik91zEN9T9sO
	 FRAkp/dc4tuhHSbNX5B9EYD9WSoXR1kC6Drb4QQYwGacbuAXtJxvkHDARfggPf7kxjLqc
	 jXlO9e7uIvLdo8Yp1xMQi7CfQD//KcNkaFYj+60uByNrKztemqA2FtwBfbDvqi2Z9KENx
	 UpWkW3WVDLEGVeZaBn7ToAfPIGrKdlqyLX4VjA7xQrq3VbpZzk2OyQdL7g9fr140Ek8Ol
	 7W+8w/Gk7JbPCgg4XcFXxa3+AL8SqlGZTYv1AJIA5qpHGJE12k67ZV7vNGoEYR06r8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793922403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J6KiWeVGisFsmwC3wX4yS8VGNysjeBCcxG86fNcWx/U=;
	b=n/R/fIDzoe9yyyNtF+AWsZcK32o7nEbp9tYfixawtUpQW9TDrwog1JcMcSU/6SgwSoi6
	 2knp9FYTqkQBxJ+OTsy/KjyE0sxM5rSMFYsB/ZrS6QKK/+o0KWGU4fqWN0gvjDOQWrApu
	 NrMF9US3d92bA/faagFqhIGpXgX5Pxx+RooSltG2++dIJirnrECjFNXgrPmx2PJ1Y1ryl
	 PUPrd+WMyIQcxqAndZP0kI/u6D+KoibhOKqF8mLMLYEGLJGY5YSDzC8pfkwEKp3pZXKjS
	 TgzsWVflm3seu6YUAZ7HYKNZj0L75WCb9uG97TbG3yu4v7dCvCs8FTUll4WOeFonmDw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=B2TrYnIU;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793922403;
	bh=J6KiWeVGisFsmwC3wX4yS8VGNysjeBCcxG86fNcWx/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c6ELb/jzBEcv1zghKe5ZRpFebjatA7wnoI3u9e5hW2wDoSbonYXzeRg+58MqJiJ8Y
	 xBK/jzydlKYi72InFhE6uuP4czB0c9lSUqnbgE2lG/FWf0324u/UICrh/FL0jlCFaJ
	 tKuYhwxurz4/3UweDXwaTrgX/aNagyfe+xl/+ZHR89mBu9afgvUNYNDY4ejKDKYhj4
	 29abGzaLB2amYwu9jmwDOoFS8aKIk02ix3GsiAvg90uQTonkA5aeuKZQAaz8ojwD5z
	 mnme0JRFBuveX/Y/wkmseV8nmfRzvvP5mvUTGtfihfaSzaujr+ACQ/sRObCpFpaOCy
	 ZtMgQn4djseGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE4F81201;
	Thu,  5 Nov 2026 23:46:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9ED995F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DA63811E8
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CxWzYbUNUVn4 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 23:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E0DF5811DD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=B2TrYnIU
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0DF5811DD
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:35 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6dd7070699eso81253eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793922395; x=1794527195;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J6KiWeVGisFsmwC3wX4yS8VGNysjeBCcxG86fNcWx/U=;
 b=B2TrYnIU1aDi084HVbGInF5kp0HO3AkMMBaY5fIuKu1ky4uHvzl1h+q76352x9aR+T
 JlIcw4yZRSSecN3us1ZrWpnwNziTn9b+Ite0P0XCrwNp0DI2ymktVW+e8DlSTGnlCN02
 Xr5knQ8FUKxiGCPeW3LxZx9Js6+a12XCyI+O7xjYRrwuyAlMAAkRg7SmPkrwk4P5FW2J
 X5UmMBreaFTKQO66tPJGnFvcZpTEAfeqdIpyJOJGNPuRQROwF+kyYol0OsYudOmasf7J
 Y3xrywOmaI/Gn+ZMPq89BjwFotqXGzMOcaga9qaHexCBmLzYORKjpXDTAK/L6yCDEzL2
 dpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793922395; x=1794527195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J6KiWeVGisFsmwC3wX4yS8VGNysjeBCcxG86fNcWx/U=;
 b=Cshptcke+FAlMPszbdYPuMjRNaQlt9sRCJXfHOMQk4zJwnhOV2jiibMH75p7PUE92/
 wxomFKK3aOkpapNZfbR9vv7oAOsGO65GVJCWqYE8p/mJkpLzf49mSkLb1nrty6K9Hxch
 KhzD/g3Sj+86APEwhcBtZyBMcVA/IH0m6tHAnykp7ub04qCtbdGlAwjnpNGts2ZLt0tq
 6QrT/SwxhsHq+E2dOoL8yDrixUgnXYRJY5ExATotrFtOIytA2nKJHhTpdAqOFgYmaAkr
 PEJgI4hAPMZrcB5VkvVKgm+hbDhIwaNLj9SmTHcp/UDcxmL0iSUbQNXtrdVcF3i6PWkV
 qM4Q==
X-Gm-Message-State: APuU4Z+0Duhbf03h92j93IMYAbj4ZrPjNwCYj67SognWoO/+mRZhTJhi
 F6B26Sq16wrBzrYe5QLXCTHRbwEVJ1wYBB2WT/Y9ZWvvF/6PoMs2nasgRSPdIYKi9xE=
X-Gm-Gg: AYBFou0KkvKy6LosY8Zq6iFulGhcaLe3NSvn5p06OHqoW6QSriCHP3RpewTZGtGD3tq
 0oM7e32/2eA1i4ksgfUtbDe7BAPbyi4WIgRNhAj6MZWPI90Yat6L9i9V74T8pj3Purf37DMeDHu
 WJG3e2l/Hd0vZLaUCsKu1qzzblRY8TdHKy/UKw/DYb8iBLL0+a2rxJbl965Ul4MoxZBsKV3gltD
 fIj4EEKuXcsObsGIBADi2arDvDezYjUlzQ5AQW9nU6L53aQfXMmueERGtp+0t917xnyb7dcCDCX
 QkUG4uew2QNADQ7togAzfe3lBEm+yAPcgHg/R8qwgb7P74cWb2LFppN/O+dlnharGGCir9FtBVS
 bYByBKMrRUMcm4R4Spx/n3aXjqDKb6YHYFdfK0dIzdkw2gGKBraUSpW8dgYEVwvuCtjM8lFKGPq
 e+9sBpX0gvS3Y/CDWsjpAOtfN6DXMEjikqH1cvINRDN8e4EIausMSt008dqgUFM7rWYYxyrkvQb
 egnXWKaCCrj2/PtOwldCOWziZwym+WRAO1f5RyUIOSf/HZUhoNCFEmMD0EH9LEmrakWyFY8dZVJ
 DL5OapacvTmSlmx0372PvMrz7YvMDzc4C1M=
X-Received: by 2002:a05:6820:2383:b0:703:acdd:d16c with SMTP id
 006d021491bc7-716e78ed8cdmr714428eaf.39.1793922394644; 
 Thu, 05 Nov 2026 15:46:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de4e53dsm592122a34.20.2026.11.05.15.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 15:46:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 17:45:28 -0600
Subject: [PATCH v2 6/8] arm: dts: mediatek: drop the DSI reserved memory on
 Genio 520/720
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-mt8189-tfa-fdt-v2-6-c168a7b4041c@baylibre.com>
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QGIjWftBHnRR+9HJ6q4nR/RAJjGif3Kdghq1QnvZDCY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7RU+lXZaawo0UWeqe3zEoodvoEnNRHKHWl4ac
 xvJUUyZwI2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau0VPhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+UMH/iATIxH0mMNGSPFx5Na6cLjL/CG3OxZsQeK/xEQ
 8rbNiDxM+LLH0k/GM3MYirAdnRX+Q/UPjke3xKXz4+JOW+SwBjpAw4vCAgQ3E755XNaDlkjLfuw
 3RQjkzU76poBlNr/99ZXaZ05khlU+/384GOq86OoLrivrFxyckfK82Luv88IeSgFQ/pkkTG7jqN
 0nlgZQM+HWHMi6pfGMjNlQysYpwG7CxDrHMVZN4n7Jx18bGqPr0npgztIZUhiG2LQ44hun5awQq
 nRYvpzbnKfhc2r989gkjHTrFK3YOk5cItuYg3L/Hmu3XO82RcxR2ClkFTBMv3NwwJZwUU6eGVml
 hPiE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Remove the dsi@60000000 reserved-memory node from the Genio 520 and 720
EVK devicetree.

Nothing refers to it, and the display bindings have no memory-region
property for it to be used through. The MT8189 devicetree proposed for
Linux uses 0x60000000 for the audio DMA buffer instead, so passing this
reservation on to the OS would take that memory away from audio.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index 0ecd10cf026..5b066906206 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -170,11 +170,6 @@
 			no-map;
 			reg = <0 0x43200000 0 0x00c00000>;
 		};
-
-		dsi_reserved: dsi@60000000 {
-			reg = <0 0x60000000 0 0x02000000>;
-			no-map;
-		};
 	};
 };
 

-- 
2.53.0

