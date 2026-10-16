Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2972CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 04:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86F2840931;
	Fri, 16 Oct 2026 04:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UlMjDVMRL2vp; Fri, 16 Oct 2026 04:02:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D84174096A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792123363;
	b=A+izbTX1PYaMcQoXJBYhvU7jAcUlrJtg0g8xZRU3gbseV37oNWz/2Dohs73gx6YRlZ/7
	 YMSKk3+K1/6QCgGc7Kxfh5VBuaJ3MN0iXp0d27WsTCxUQLj2cFPiUbADStjOJLqX1EFgr
	 It6SXdMZnJ/bQSEexTFESCRRr7NVQzojCEhnjtBQpkZxMXOnyPia1yzahFTXGNQ+qS48d
	 R/EPDEDrbJoj1VX8SBclS2uXyLJrjoiNk+QG/n7yuac6jo5+xTzmzx70sAdHsY7NYBnD/
	 zZcKt14DA0QeheODaY9WrQ7/9C3hmhY6guUtv1lbqpnhVjILupuK8Ha0fYtxbnodlDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792123363;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bRb3qJqpleYQfNP/Y20FtSapjQ1Jsj/97aDMpZCHUyY=;
	b=P4F5RNzFcMHZczs1vlQJxjqutlUgROawRAwuaOnR1XMv6cIIyWctsolQ8EMa3vu1/1B8
	 /MZ5oYOqAIp4S23wsVd597qHksHClT2XuBy/G3t+AtDtWpaPncIbcI4ias3vhGDqgsGhT
	 IeK2xYz6NRmzuJqQnvjyTOr6VXC6Ahg2SEfzTGx7AgS6vgdL7CTBT7TgCC1I+5dLeu70p
	 IbUqOBHcP9oXXT8oUjytsTUXBw61CqAIeQctpKIrTSTo1X+1IyEuwVMh6qzM4sYDVvBBY
	 T04IM/k7/HK86yYVbzWxHqniwiTueC4MzlRLy9NhPd0PNFAYGMZrbJixZ6PrK1rV+tA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792123363;
	bh=bRb3qJqpleYQfNP/Y20FtSapjQ1Jsj/97aDMpZCHUyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XJCY6737pAYY/Vm8K5ZSF0eVna6sGYJ5+JzonceyLbx5W02Vr283gMjFy88gRzvnL
	 z8nsSviyELfICq/9Ao+fovNOPeL8M1SBx3NNRM1pTCwm4XBJ+43VgERWWl5vWsmDL+
	 Gv30dPigOeK1IINE3Gw/J717tpqb1C1rOLZMP1IxOlCIChqnrVb9pcIVAGLsw+AIPW
	 ktJjpMVy/8pndpPowilAPJIwbrZ/cGkPbcDN5hS6vj6zgCMAx2EGWGjKZsoqqtk1zf
	 fTM6zoW0Mvnlg9fql9TlDDbIt4cK783rLIJOInUzKeAvzZFl6CvcTcM4dKSxeZntsx
	 H3NefKSfwRnKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D84174096A;
	Fri, 16 Oct 2026 04:02:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CB8AF109
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1F07400B8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQ5JhUfSEiKn for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 04:02:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0D08B4009C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792123360;
 b=Ji+hezTlH4tNHEal2n+QDPvIcFuOnshuSo3UtSBf6zGcRmnRzqF/AzJOp+h9iCm5zi/E
 p/kwIgJArUS3Y2ZGxfYzHBDdpsUXY9e2uBln2kLJ9XlPMbZLgrj+X5n9w3B97gGVsg4Dm
 UBeck3cGPc4jpFOYPGPm3BeSWcb0Is5oa82l+avwZQUqP8gyT4ksT/7XeK18UKLO57plo
 daFJ/1zHJdEjlByjjTY8zBdinVVLUoZuRdFvVjIH3mFx9L+ZL4SjHtjLrpJacQn5o9fay
 1ovaPMIrsOLKedBprUrbzv7rhQG4UvzTRNg8pAfHgA4OXl1NnrFab1GoeGvlmt2seJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792123360;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=bRb3qJqpleYQfNP/Y20FtSapjQ1Jsj/97aDMpZCHUyY=;
 b=jVSLRQj9cyg1dbhBWNe2N7Q2jsQ8NpZCyVBRSq5isTrXFBW20xaEMEDec/QyAWX6PkkO
 EZkjTyWlx7qLPLTTF8rYBg/VawrSYAOzFBThHLigpHp3eS96QP/gWB7EEfue3tU2l/GKi
 Y4C5dOkSC0y388SH7JvsOsDiUz927xWmUfuCYYGTs5vMoq9whVVaax+Uvfxx0ZmuBk+O6
 Hrr4QnKIgkkLZSUSRJUDgTnynra0NqnQYPnGZwhZdUNk/rLhzlhpgNmfTGd8VWMVJDAIb
 +FoklV40IGOxF1qclhB/wSrLaycliKmHTeZUHWx1v7GjuhsdklwhAePduQIDO2T+VZg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GyhhtS93; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GyhhtS93
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D08B4009C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:02:39 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc50ad2d650so4481557a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 21:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792123359; x=1792728159;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bRb3qJqpleYQfNP/Y20FtSapjQ1Jsj/97aDMpZCHUyY=;
 b=GyhhtS93aniiXkxM8JNn1qaOsjS3nmTzmOzPjHnjaz3SP8FTVnJrjIb7hL3e0ARyQc
 /CfQXGWXFKgXglpcyGUafPUUZO3fqYDyaKLYKIaonpE2uA7bGLuW4MWi0Whcdbz0oGA5
 litYnGeKynJB54ZXAhiev+SvItKKR+EDiaxRjIQIo+fcoUkjsjY8gJjEpK021dgbUWtg
 nAdwIMKQ6EaigjNHt92f+a2kNCUkdGausAG0QhledrIlQWXMrB5dFLJ+lVSS8OVJ0K6k
 XG6KASXqwByd1C3n8YC8DuDiPBdUCSgOcBIy00fKPtKqtSVKrYkrjdeVF7arUqkY1wb4
 XK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792123359; x=1792728159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bRb3qJqpleYQfNP/Y20FtSapjQ1Jsj/97aDMpZCHUyY=;
 b=G7sxYan1I8sKq5u8DyqO/Oie9Ji7F653inJc6po0Yd4XH7z9HHDBxxYuD6iQbaGGTl
 ZBJLLmMDvz9SKeTB7yugPTYN6PkBwTcp+VozSFNRCgV5SXIKsZd966oiMBJbhLBHqFww
 aEIWcebE86jfier/Gk4IgdSvEEl4pXaZj6EVrSRoLSNoDftLRqQ4/VcxjwmKIinBqTpi
 SpLRcpFQhMNNjwRtx/j/+s7SElAE6OtiCkv+D16HCI3xX3dbwzMSs4tOav04XHxI+0AS
 ceSRhy7ZWav5S2aEKCmh4l2C2SqH0i3dMFg7/7fNyE8gTyO7xHAjMoMAp5GwJOpkzR/p
 RI4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLgMAEqIejUuh2dz5EDqlSDGkQkD4cqwZZyWab9EMJMTHfNsMNgZFX5toh4XOMAUdpkw6QZy4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJH10JVQ6GnA5jo0QvSSz3ZJUKTKQiS7QIxTbeLXQhpfqMN0ILh
 NOAkCrGS4HL0xYAL/00aili3C/oJsDtBS/cVx9QNlJiY2kLXnw11Z7XJ
X-Gm-Gg: AYBFou2KVEfrGMCJnormkpQ8IGm8NYlWIbCso4Dutsy+h8ZxwayatQzyMcgDm5D1FBG
 NhDlgMgiKLinr1UNvBkU5qwG/b+s+sj8UPenNw0TO8JjhgYI3a/wxPc5B0PTWvdfYhpZaxa/9NG
 FXUjRDxeAhH1bNWTqQG7Tv6c50ijRn/6AMRFO0U2TBJcpB0sFnwwiQSVZNoLQ4iYrCykt9zAPJn
 0byp1tpdjVk7ajo6o92aqnaezsiOs7l2jgi91kn9HTdz/Q57850IOxQdWZ2XdReDRDo7102n+G+
 +Qx+2HR4MUfnThWOx04CBzh9WfNKw7p9Osg0XkNzvgxQ5hKYt9zJhncvoxsADEkD0/ddrwzhV3N
 hRWIhq1VTCE5Hj3m3eLE3lPyWN1F0FnJkH6vYkCyijpAWG0TTZkjSbULaleCSLlNKOCND49jACA
 RMQY9HYl58sjydVipXMpKpoo/wfsUggdjKSN6hcQadiODG5r0C1ZR1nAM3bDRepzZalVGT/94vt
 xTk8xpXxRMA6F90udhQH1SFCIv0TvRuP0iKOZCpYizxuc5XeKA7GIi/KYSS/Qw7pjIk6q5NIskH
 2XR2MJtvGdVCC8hqEv/A6Ojv19MOwX7P2MEyxx14x6OXCvUAu0Zy5SE=
X-Received: by 2002:a05:6a21:4598:b0:3e1:5816:8749 with SMTP id
 adf61e73a8af0-3e16be31c87mr18329335637.38.1792123358811; 
 Thu, 15 Oct 2026 21:02:38 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd654a249f3sm437294a12.27.2026.10.15.21.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 21:02:38 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: marscheng@google.com, eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 4/4] configs: google: Add lga default configuration
Date: Fri, 16 Oct 2026 04:02:16 +0000
Message-ID: <20261016040216.3636305-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261016040216.3636305-1-visitorckw@gmail.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add google_lga_defconfig for Google Tensor G5 boards, using
google/lga-frankel as the default device tree.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                  |  1 +
 board/google/lga/MAINTAINERS |  1 +
 configs/google_lga_defconfig | 10 ++++++++++
 3 files changed, 12 insertions(+)
 create mode 100644 configs/google_lga_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 7546eeb3f9e..cccc40c89c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -362,6 +362,7 @@ S:	Maintained
 F:	arch/arm/dts/lga-u-boot.dtsi
 F:	arch/arm/mach-google/
 F:	board/google/lga/
+F:	configs/google_lga_defconfig
 F:	include/configs/lga.h
 K:	[gG]oogle.?[tT]ensor
 
diff --git a/board/google/lga/MAINTAINERS b/board/google/lga/MAINTAINERS
index 1dd03afab42..801b1fe6109 100644
--- a/board/google/lga/MAINTAINERS
+++ b/board/google/lga/MAINTAINERS
@@ -3,3 +3,4 @@ M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
 F:	board/google/lga/
 F:	include/configs/lga.h
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
2.56.0.212.g129ede20d9-goog

