Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D9F606A336
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wR4avWdY;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ZhtnbsWc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14C5560757;
	Sat,  7 Nov 2026 14:32:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dl_ovjqTH1o6; Sat,  7 Nov 2026 14:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3562260744
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061976;
	b=Xq5QetyvFeVZ7GNOhigy6/HDqdiEhIp/olu6ivS5geKT1zk7Z5SMKIWnBYizH1bynzRK
	 yGHMckCCjauIJMv9zuzbZ9S6K+ec3lLL/arFHdqoBANfKlT4Z3E4Hj7ViKhYYW+F49BKc
	 wIkH0pXjI/JORhKEySHDWLbyy42+XYw60wKfYzikIlMk52YXNM28QcYLVHMQh1FWXdad0
	 FjdrV2PW7hK/5mF8t8h+kw7zKBKYCDKH9LBeIJFY8z7eztyFj43KhUd7V22C/a68enqD8
	 O6CvymjIXxVyVm4QlH9XABsl/kGcAv/npH8e4AqFdqGp3OAbb3M/p3Zb0jxnjdGGBug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9p4WOet8AkILhU5f/VlUZibOtk9yEUT7JLGreigcNes=;
	b=l+d8rBed5BQdV1rDG/mB40s9QBFEc4nu7thnrengU+tlxmi85v/GqKMTA+bY0cgnjriy
	 LtLLW1i7/R18jmwJtidyDFrSYs4wSStXRSr9nmzBBkl46RPea4QgSQ9Lon8+iIozatmVN
	 laz6CSMB/B5gT4kFIvFhTjXEOOXbfjvjFuM/lfERJsILAJz1siaeT4jdCzQwYKgWK1hK3
	 LZoSmKjjAyiyAlyB9IknjO6phO1ATqLoQtL3ZGpG3THZgpyE24yD9Aa8CYVJxflxt93+h
	 mkwhWkLaR/sWXAjpmsYXt28XikH2UElEWxXn9to613zMaqNcbu5VxbtCzm2BqatgKdw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061976;
	bh=9p4WOet8AkILhU5f/VlUZibOtk9yEUT7JLGreigcNes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wR4avWdY7NLO2VdWz1KrDF3P7yZ8NRsbwNBTAHdwTDZqLiL09/W3ORmytq1/Zw+ht
	 tfpQsGXRf8cYRvIqw9gAz+YV/8xpjEzP0dDSlKD83jqh8oblbE5dqV6ZUj5Fzw8QgL
	 Pp6fvGX2DXZUK6+VvdFuRejLseY5dbqVI9zwDC4mxcFJ84Y4u6/GdbU+xYAcs8M8du
	 /aAskUaVWof8cvuFt+TyTYAY1Uf4RgteeUr1EtKQfAjW5ZrBFmo8JrKZFwStpb/Ynp
	 EW1hwA2yQi5C6VI2/8ykQo3iFMUYI6WKFHqp1Dtc6Rm8Ay2IeVsE9OJoe1+LbP1B5M
	 5v7OisEtJD/zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3562260744;
	Sat,  7 Nov 2026 14:32:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C342211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 227B84075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F6Rg3fKtNcJC for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:32:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F2CA140757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=ZhtnbsWc
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2CA140757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:51 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so908313f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061969; x=1794666769;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9p4WOet8AkILhU5f/VlUZibOtk9yEUT7JLGreigcNes=;
 b=ZhtnbsWcIGIhkre+pQ1LAS7Z6XELWk11kfmS6sLQa6FzJeFqnQE2eL5KuqBFj3ublM
 9+OkemsTT5CWGGin0DzxrQ3dX4oRzUAS6L/4+5D28B4aSOCsNo0thHB8t5F3Q15+naxK
 LTeiNNWoWJblkALQ78BKRBB+EoVMxB6rQ8GAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061969; x=1794666769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9p4WOet8AkILhU5f/VlUZibOtk9yEUT7JLGreigcNes=;
 b=jFQIHN0CyYki6+dyUtP4vPmdu0JfpBX8m2Y5gqA3xVZz2yCBetLwmjFce56eEbHTk/
 AZFmYVQvWx8YW6EzPc2KcSM9mIcWmXIBHEqF7ofj9lTNML5pcbuQAEGxLVHWDB5khQmH
 Qefc1Ps6YmuG1IGupRieEyPcrlaV2JCHf6OFFRwsmWJRFHvdT1vt/X2dtJEg0+Kef++R
 qwqR4YZgs8FJdTb+ytX4EPVi2Dim84ohGnu5zHFHhmMm7brHf4JxtIYlLCrAwlekk28w
 Zs2DrESlINCQoo56FUqXFzlxoeHkbYw1YECf0Dhm/VRei+PpV3dMswuntvX8Jr8DmHhN
 XTzg==
X-Forwarded-Encrypted: i=1;
 AL+hErEdlgOvXQm96nmWn9+NKHTSApcq0PafYfEdTn3o5rXjxIqqhKg+7DtaSUFIzfb4nrd0a5Ho2bg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/B0v9OTdwIO5P1V36s20CAKfeWMHzABXOZNJiml6Img3gH0vUE
 OdIGoYzes3Aay59cyP2yhNCa//68NRJJFyMHk/1Y849RLY/tW/kNVG2YHZiV3n+xl4s=
X-Gm-Gg: AYBFou0n+IoRZ0qaSQAZPPgxnmYf7tQoonuAYKQgEll1Cko6mRMe3rku0ncZOw10eeu
 0sxxvdgaon9eCo2hY9EOyt4ZEqH9GGx7U07BPy9lUX2L+wGIrwR/WmLOpRCh++RvBhScOYlBJSn
 yCfT79IQgMCVEsfQL7rtzynTz5DFjmNQB8UReLQMDLztbj+Glgoe3qBhtVBNNMSE7EqmLaLxQ+A
 HKYLS/7RRUWI8DcI/MO2TQAoLsRF7vMCUPPWkYjd0jPvoladBtXABmFHCrSj6VomifVvrm59g3t
 VBwcOvdO4we/wA38CMT8KqVVjoXK6gL2oxSuQNCjR4ZpwfPXw7t2tHBqy/nCz7gx1a204lNxhUe
 Ib3aehqmcCsg5yRKaEyYnOkRg8v3xDz1fJ4kpD90ckbvJWtwQWHsYUWokqcVM7oS3DnIQY05jGD
 ukz3lZPc4PKGGQJpJTF/LYo8x5MSmKNVxMoaqf35C8xz3Zlg+dMK8lP7yewgvHh1nmM1WABS+xY
 GnEs8eUgGIdKo9y1owat9+LcO6NEv3LgLvHMd5qNx2KAG3O2WEvFf/2fDVMOpVB8WtaKQyHYJUP
 5gi2v0qqu2yOXaRS2w52e5Vnav3DrYcP+uUtEU6iJIgH20n414rpJRSYuAxJsBuCX9qT/BCe0yX
 a4ts3v4CwkaSOxyTeDOZye2+FUoouzRQRE19+IW6oA5BDktyoE/DjQk7wWPsva95+rPYYPksDo9
 BCuF+FipbxH0z+vkIXNM8Yl39mgo2UjQN6XT/JnngD7K2624Q=
X-Received: by 2002:a05:6000:22c1:b0:48c:72fc:363e with SMTP id
 ffacd0b85a97d-492760daf40mr11925754f8f.44.1794061969435; 
 Sat, 07 Nov 2026 06:32:49 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:32:48 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 02/35] arm64: dts: st: add power-domains to sdmmc1 on
 stm32mp231
Date: Sat,  7 Nov 2026 15:31:52 +0100
Message-ID: <20261107143241.2236511-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The sdmmc1 node was introduced early in the SoC bring-up before power
domains were systematically mapped. Add the missing power-domains
property to align it with the rest of the peripheral nodes.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-3-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: d92944ee1693b20c71215c3ad1a1661f05e85108 ]

(cherry picked from commit 38e8d79eac568b36a01076a5dba1e85676eab895)
---

(no changes since v1)

 dts/upstream/src/arm64/st/stm32mp231.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp231.dtsi b/dts/upstream/src/arm64/st/stm32mp231.dtsi
index 9e1d240888ff..0feb8943efae 100644
--- a/dts/upstream/src/arm64/st/stm32mp231.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp231.dtsi
@@ -727,6 +727,7 @@
 				cap-mmc-highspeed;
 				max-frequency = <120000000>;
 				access-controllers = <&rifsc 76>;
+				power-domains = <&cluster_pd>;
 				status = "disabled";
 			};
 
-- 
2.43.0

