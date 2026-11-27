Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A68606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LrsLJR9j;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l+gL8rCq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 562B940A46;
	Fri, 27 Nov 2026 06:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b9_FMrmXg2ls; Fri, 27 Nov 2026 06:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55BF740A45
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795761413;
	b=jqljunrR92LvXleC5XmpT/LpDgAwXy8kuJCNW1oY+6JI9tnS8CuneswnnykcY6eytRtY
	 tiXc+ydQfnu2J0mFrT0Xl5UxutQK9+5kQvjAz+R0sbd8aSq8C7gj10dbNhBL1/tjhIZHt
	 DPQirhysl64O//hCLar3dlBtzCTCXxcbhw/VYdWylbqYR8YnZpjjmd5yXyo5WiIdKVN5P
	 wGh6AK4cJEZqHktlKdwElCg8NFn+HCjRG9Wt4K4OZw2+DJUFVuu34qwM9VA58aP+Uqevr
	 8PX4etaqQPjeXS0gqOQEP05jCm9AzySWVk6vVaKl4RAA2psmIgUIEMBLU+8Ywqkz1uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795761413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xHlmqW9DMdYRYg1PWgLe09qCsWvk9OlB3gjaMGz0q7Y=;
	b=bzJYf41yDt2c93TMv5YQKDmmcclKWgwrJrWa3C1Ana0jAx24KtSCPo93p32YRZk42JVY
	 JApiUNgmxFq1yIVyNXqPz1AbPVxLQk+u+Jb0RhrBb1iwlyak5hE8Z5vuJNiqhWMIi4S0g
	 5Worl4VrH/oaUg8DbjdQPc8PsfsnZRXwgIR58EzWKlL2rcI6PZ1eOEG/mUmFZrMP+E9H2
	 vmkAfR0ytE2FWeJebhLk28dP+MZwDvo5x2UHgXyV9DzoT2EXvI6IYxF8P/MYMnKuTfC5n
	 yOUPlupXbdtngp80hnO1QcCeAQcgPdYjv/RlhgmSnwRxSyEFUoaVI2t8lBGMnA3urzw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795761413;
	bh=xHlmqW9DMdYRYg1PWgLe09qCsWvk9OlB3gjaMGz0q7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LrsLJR9jWOMDEKWtOaK+jODyFNjTw+/v02RJ9zOv10NCj6yxyffVUbrX76vAttYpC
	 nckM7i01mmZ8hFZD91FKPtMVVLOU63SsnoLnTVdksKpvClnMJsFozFl5P+eAInyVXL
	 cJvRs7+Gy7cY2ON9+lNV9WZqfW4CWQOzVz91EizFucEdGJ59bxXzQZBKW8bcL0SRkw
	 +Ffa/Kg6ohFYxO47RHVP6nIn6ipnHd6ytg9GLitVm39+kcrwEhT3aI47uRc1mRn8uw
	 bAMtggixowTqejkaMRTr1iSbGDJJN0aRkuDHgwX1QtLuo6znc02ZUFh3azac2+UqBC
	 CoAu6LDc6TusQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55BF740A45;
	Fri, 27 Nov 2026 06:36:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C862266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E696440187
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MzPr6ZnGBm7e for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3FF074004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=l+gL8rCq
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FF074004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:49 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-3866a784546so10616546eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795761409; x=1796366209;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xHlmqW9DMdYRYg1PWgLe09qCsWvk9OlB3gjaMGz0q7Y=;
 b=l+gL8rCqr+cMzdyvYvrdGFD4ecF2GblzhzXrnSovxA3ooy+RHtfJ2+vVaeLhA7v94F
 u4qWpofERe01BDjbbi2VBRNJT5J5DMS3eWTATnMRsYchxUuOSMc83NmM0oZSJNE4K7IA
 aYLQGa6/NLcQovyyC/3K6jE8uE/pUPTtmoYqOALa3Ql4qiRNXMuCKwK66tYjiey1HnN6
 KFfZvEfxWNsff8MwwlIhpFbTe1VdQe0sPxWCKXUtmvisjjqvQNuwxUXricXzJjgWC5Eb
 a50SaHhUAFux8QPYUXuTjwGyL0QYpQNZgWL1cgQukxErBMi84peWk6tFWi38YFgmymHt
 z/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795761409; x=1796366209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xHlmqW9DMdYRYg1PWgLe09qCsWvk9OlB3gjaMGz0q7Y=;
 b=V6GudfIx1DN8qMp5PZdL2Y1GvhJB6pMcSqsvEHg25pioh48Rt84cxzZrRqDwvBMxUQ
 LbqH/BuJE1E+deOhLFinxEPgtIum5xcq6Y5qe1bf1WO/4kaPcES02t2rb0yzWjJ1NNH8
 C72pt0myYiIvbUzoE445IcC9LKKlxziyXfs1upOW5dRUhPZAMhUsu6BsFele5cNcp+fW
 itJSaJJKsV9RHDeezmVKxAosWTZu3GIZH6CwU+loyaVRZqUWkEdOVAnsc7XKHDw6TeJH
 B0zVvEkroScjRAmcUnNG8D0dzgebF4GVVgLw6ARz4aENhotIbIMOt3owCUjWtk5KDF9C
 0oIw==
X-Gm-Message-State: APuU4Z9d3chsFe4fOcaMM7g2w3feRWQw2QkUHumdLPZZ3khVzwCYy6Qc
 v2Ufj75kGcQNLjWDOmbI45MhENo0ipHJsWcC1c6a93NgB4PwTmd5OfXK
X-Gm-Gg: AZFdTZcWJdSHu8tWO0zwnIGv1G/IDZQPVcFKnZI9+XtjA6BqAwj7Kw6QBFfNI8sinGq
 SoEujDkb+i5gwUa6d2Q1Q9ODjYyXIMYP7OjnM5YsOOBIKmS08WFOucS2ZFcql69Owvw13ZxGY7l
 W3tMBN+DLykd6ihZ2Y5LTA9DLEaQWeJSqMAvYeUKZrI7reWN+odm0ZKosa8r0ELLD+su8/D5tqU
 VNbfkcEYzIAuvYblRXLVbDt+g4jx94Uu75AbzJbxiPn2R4rk/p0CzmwpfPXppDtBKd1umeqvQEp
 4qAbr9Qa4yPKCsawVdm/gEIr6VuQc3zyJZYo6D37S6l2U8ZvhP2Jt+UrPBUQKIKj9hTbIJaXUn/
 YBLozUVl8fZr0tjrsdrjSJHwFLS9Pjjyzg5/6lrps3EKdkBRzW8zqLDpfrup3bOUGPJzSzOTWdM
 hYiL8clYdBaappnhRFFqtqYDHJlS+aKS4fkKlpWQHGNlp5MTx3q23y/q0LLzcnPE5wbLquW3PX7
 HZfN8Gx6JI0V+OFmT3hHIDVChPj7gPhBMQPvgSyQIyjENiu4DWKOxHYcH5W+QCxX8F72Ola5DnC
 MOvVsp5AbMwYdDVkj/V+1oy2Wo6gjFE9S9SrpGqSvSitc94oEg583n4/a7fiuXWF5rSZ/wbBW9s
 ztls7Jcs6MfmKXtqTS98cYHY=
X-Received: by 2002:a05:7301:4d11:b0:386:c666:ec45 with SMTP id
 5a478bee46e88-386c666eeb2mr8561896eec.12.1795761408869; 
 Thu, 26 Nov 2026 22:36:48 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (55.11.81.34.bc.googleusercontent.com. [34.81.11.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672c6f31sm67452444eec.15.2026.11.26.22.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:36:48 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, visitorckw@gmail.com
Subject: [PATCH v2 7/8] configs: google: Add lga default configuration
Date: Fri, 27 Nov 2026 06:36:19 +0000
Message-ID: <20261127063620.399391-8-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127063620.399391-1-visitorckw@gmail.com>
References: <20261127063620.399391-1-visitorckw@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add google_lga_defconfig for Google Tensor G5 boards, using
google/lga-frankel as the default device tree.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                  |  1 +
 board/google/lga/MAINTAINERS |  1 +
 configs/google_lga_defconfig | 10 ++++++++++
 3 files changed, 12 insertions(+)
 create mode 100644 configs/google_lga_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c73992ac97..09efaef4066 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -362,6 +362,7 @@ S:	Maintained
 F:	arch/arm/dts/lga-u-boot.dtsi
 F:	arch/arm/mach-google/
 F:	board/google/lga/
+F:	configs/google_lga_defconfig
 K:	[gG]oogle.?[tT]ensor
 
 ARM HISILICON
diff --git a/board/google/lga/MAINTAINERS b/board/google/lga/MAINTAINERS
index 81894f1e0e7..c5e7a2364d4 100644
--- a/board/google/lga/MAINTAINERS
+++ b/board/google/lga/MAINTAINERS
@@ -2,3 +2,4 @@ GOOGLE TENSOR G5 (LGA) BOARD
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
 F:	board/google/lga/
+F:	configs/google_lga_defconfig
diff --git a/configs/google_lga_defconfig b/configs/google_lga_defconfig
new file mode 100644
index 00000000000..f30c89fa279
--- /dev/null
+++ b/configs/google_lga_defconfig
@@ -0,0 +1,10 @@
+CONFIG_ARM=y
+CONFIG_ARCH_GOOGLE=y
+CONFIG_TEXT_BASE=0xbe000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="google/lga-frankel"
+CONFIG_SYS_LOAD_ADDR=0xbe000000
+# CONFIG_EFI_LOADER is not set
+CONFIG_BOOTDELAY=-1
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_NO_NET=y
-- 
2.56.1.839.g22a8290db9-goog

