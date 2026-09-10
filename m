Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E5DC79FBF
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 20:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0626081160;
	Thu, 10 Sep 2026 20:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrzD0x9esCTC; Thu, 10 Sep 2026 20:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4D4B9811FB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789070610;
	b=pUSWD7MjbOyD2u9vbNz8bSJ24yz+HbK9ANqe6HLFhSv/f3ZOU9/eRlEEBmqmhJkrQks+
	 9oc0G01bjSTTJF1eM6hf4P539AKp+QoyRN7UhE0VxywU7EcqK7WZxbf1kWVGJecM5GU9o
	 fLH1/rDsxjFWjbXBLb7JcoIv5EuM3TGg0VzGFCX1Db6EBuIIny+nGelmOHD6677noGzcT
	 xKyghNN3axReo2JOzwknntzIwaWwKZTxSlZRKzvPdw6E/hL9zF6Mo5WnMwaWqjsjYXCeM
	 77cC+PWevhTrvY2nUho355H6MVJrJr4m//VWeWZColevSUL/Y/yQC5cBzh9Q3fMOIRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789070610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=M2UusRCakFDqnvZzgKuVWAnIqQbv+kpNTT5uSGwBG3E=;
	b=SZqPvWSektHEt4uCyP8Vj2Wxx58Fa+i9k4GUPZoXKsuQQ3YG90J9UnU+vbZ5dhxSOZ2V
	 d0X1wkISsU3hSxtc+ejT82B5Mvu1XvLXFcUTB7KEgkmdvjqOPHKFfzXPjzph3lArEbTh/
	 kfikEoVRTu/1gTg9KFEgklcY/e0HozUpaZltOqghmQBsYR4+8Vs4XrbJZfAZOm+AgTtLQ
	 9qQbhYDjYDUmVduczwUztnB9IyOSy5Q6zvgh8cQaXCHnXchZ2OAZ09MtfcE15jjJhSGvO
	 lP1tQuFe2TJ4Lya9vKt5KxI99o2yKClJdyPCQJrDLAylFBHL/cx+NnE9EIiQ9ZMsL/Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789070610;
	bh=M2UusRCakFDqnvZzgKuVWAnIqQbv+kpNTT5uSGwBG3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KpzH+V6DWYvdLNKGwXQNH34iNVVF5Q9Lxm42NeYmuhYdjgIwloXLNA+oWvjPNbadq
	 YJOGINywI8rJsxfJFS5wIcltGz5kn51qfZ1LBIdcFeBtfUVd9WgsXHqn30ZTAFcOdY
	 99reslpoYIVjwiEO3hPSeDdqIBH1+LUN8Y6eBimpUQ6wmZlTkWKbzKpq6/z8ofj3ws
	 3syf+J32NU56HgNxE0n2oAgH4dx1uN1vQ7SFteomwyhIobA9KO9oDi+rxLiEZ9Xo78
	 N+Prb7IkhdgUuZTRkqmCFGaSRSHgn6x9BvR/q+TW7ExaNb6k+rfFL6fq2RaxjIbqsn
	 xb0LyG7MhgCDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D4B9811FB;
	Thu, 10 Sep 2026 20:03:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBAD2786
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A19B660BD6
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EbEg-7VYtm8v for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 20:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A3BB660BDF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789070600;
 b=iwNn6MagCpYY/v8BddU+DaJ+y4FxBlS6x4F+AAzN9kyn39KNMgKW4RafRk33LyahR6l2
 rmU9eD+segrLW37Kq4k2v8mIlkC8CWLy8w2F4RvprHfjHqlue6LqI0KK8eHaRogE7cR54
 t7O3BDB/9kHG+IAk6czWhjD/K9V9T3UhbK/GvpgxozHoDtpvcBFA2CYzNDewuRnE0Z6I/
 cPjePwfiXDip+ZIIQMI3uXhS6x5hhskmk8AE3uJ01/Qti/E9WAfbW8CLi709fzj4KTAJb
 E3bGYRQ0J3CF2OndF3ON31g9IoQ5/EDwrz8Y+Mb/YJcjorlArid3y/ooWITwgGm3xIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789070600;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=M2UusRCakFDqnvZzgKuVWAnIqQbv+kpNTT5uSGwBG3E=;
 b=p95Ymu3Uld5Ie0ctPwseNVrjUFv87goyOajQ95y0sCvtGmoAJCATy5Rr0yvYYtEvH1KM
 bk82yqBd5rrL134BKxhswQCVIjn0oemaNeqhxcf3uMFLrBxPqgXSpX6lvdh0K1Rvksa2a
 oBsHTsb50gEUppTMFGq5wv7VAlRHhSOO5NdDV4IZX60KN3iZqeH1+mhuWxteREpvtFwMl
 ryGiONSvBIOzzeMrLGzdnnH+5PrGfbV/hSUMYy0lJMa4Ek9OjunOQsDW/OAqQvoyv1uzP
 himAiAjsQ6xbSano+AK5IWC697MQ3o7NDFbIlbrMvlyg754gvCKkQtWbkv0Bp4KA/lg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EkztV4EZ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=EkztV4EZ
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3BB660BDF
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:20 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-4b94bb43008so45255b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789070599; x=1789675399;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M2UusRCakFDqnvZzgKuVWAnIqQbv+kpNTT5uSGwBG3E=;
 b=EkztV4EZwtn4NZ9FM/zPeXCZCMkQvdhEAegcOmK+FZftgxP77PiDq/usxcT28L4xkL
 j0fAiQDecXerleuob/GtZhn3zlwkS0TiIijHBD0W/zXaAKVsCnQq4YeY29cT1O6iSFHr
 VzWXk6JYMI0LpZZaNYjTMJHq6N2vUBmudUE6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070599; x=1789675399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M2UusRCakFDqnvZzgKuVWAnIqQbv+kpNTT5uSGwBG3E=;
 b=nxMFmKlgU3I205X/SDuDVShrQQhJDFFBAGzLk1RlCWjK3jx47axwDD3OpJDH9rqKvQ
 +BAoLI0Do6D9dK92P2xYiMTMzQfKtAEeab/lYLOkk4iy7cEep51539lYh+GYlyBEGQeD
 tgAcK8W2GTVKFNww9S+Vq3b9cvU9xyjlcEAtS/g5DkZbeeZD2O+FKfLdXyH1NfzFu4uI
 EhS+mospv90EpIS4kTeN/2rv/C+4ZnXwfP7YfVPq7w42Qdvb9yws9ncktUqMWYUvzLfw
 vd7Cgb4e7o/ldxYOxv0wwFVcrSY9iOZn6rc3LHr7i39mJBdlJ833zygD9qcB3mWfe8N7
 sUOQ==
X-Gm-Message-State: AFuF++n5miNTkf6I3Y+AkANpvpQSjZyuPKHaCSbiBh80782l3NVrZznX
 escEeIsSSd6mkaM6lVAAAwyeeRVsa6tBvZuj83kI34dMWIrUoPYG9NNZiqlJOPLD0APxAa0gWWk
 WtC4aOwa+s+GWfRE=
X-Gm-Gg: AYBFou3uu7nownkIUev5xP40oeG0P+5SsBY3yF6b5MhbKIWurYr1uWX4zmeVfqPhU9t
 ztQnM+665vsv/kCXfjr44LE/3jdNyGdRcGYHzysKf2kkOhpojCBPSnnOf4PjdEqPPqcQN3fi14w
 8gW3WudmEOB7ySzAaywkK7Nyllqk10X6UjJWN0xttbChnQVgedHPMye/6iJimATD64wKF7Yid69
 cjrrZtMIdb5A8cDA96ewBEFSWHcnh0KNzeQ1rcD7hhpqYON+SJhmu+XqFHwIMOzMhwuvJdaQ2h6
 ipIPRJnEBMP0Z5QrGbAFJUK8296Cl6Y6qum78VHp8/E0lD98RS+H/ODPdl+t7MNDGaqDAtXlD0+
 /QS1f3Voni2dwZQvzT4G2T+IGitv4+2KoRj9dqnfUjRpylcvWdm7X6ftdph+kB8EGeX26skt4JA
 jfbOEsXeYtAfOs8q7m4E56/74FInDXbIOyHoZZLQfIsO3acyHFwFDao/GdhQugs9YEuyLrQgRVR
 yTaDuZav5DcjAvFztA+Wk/dfs48gRNHp0xSltM3rBeOBE8/PmcsxY5izyetkzkOsR7+h1mBhJF1
 QfwmFV2rfB3zc5lYFdRxz/sRCoG5YFEO5+x6QFlODmWb
X-Received: by 2002:a05:6808:1489:b0:4b9:a88b:8888 with SMTP id
 5614622812f47-4c31c407a55mr493330b6e.30.1789070599204; 
 Thu, 10 Sep 2026 13:03:19 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c331bc937bsm208357b6e.11.2026.09.10.13.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:03:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 6/7] MAINTAINERS: Removed files
Date: Thu, 10 Sep 2026 14:03:08 -0600
Message-ID: <20260910200310.3503830-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910200310.3503830-1-trini@konsulko.com>
References: <20260910200310.3503830-1-trini@konsulko.com>
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

Correct MAINTAINERS entries for files that have been removed. In most
cases this is because a given platform has moved to using OF_UPSTREAM
and so the local version of the file does not exist. In other cases,
sample defconfigs have either been merged or simply removed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- Rebase on current next, add more since-removed files.

Cc: Michal Simek <michal.simek@amd.com>
---
 MAINTAINERS                                    |  1 -
 board/LaCie/net2big_v2/MAINTAINERS             |  4 ----
 board/LaCie/netspace_v2/MAINTAINERS            |  6 ------
 board/Synology/ds116/MAINTAINERS               |  1 -
 board/altera/stratix10-socdk/MAINTAINERS       |  1 -
 board/atmel/at91sam9260ek/MAINTAINERS          |  1 -
 board/beacon/beacon-rzg2m/MAINTAINERS          |  3 ---
 board/embest/mx6boards/MAINTAINERS             |  1 -
 board/gardena/smart-gateway-mt7688/MAINTAINERS |  1 -
 board/gateworks/gw_ventana/MAINTAINERS         |  6 ------
 board/ge/bx50v3/MAINTAINERS                    |  3 ---
 board/intel/agilex-socdk/MAINTAINERS           |  1 -
 board/intel/agilex7m-socdk/MAINTAINERS         |  1 -
 board/intel/n5x-socdk/MAINTAINERS              |  1 -
 board/khadas/khadas-edge2-rk3588s/MAINTAINERS  |  1 -
 board/kontron/sl-mx6ul/MAINTAINERS             |  7 +++----
 board/mediatek/MAINTAINERS                     |  3 ---
 board/mediatek/mt7981/MAINTAINERS              |  2 --
 board/mediatek/mt7986/MAINTAINERS              |  4 ----
 board/nxp/imx93_evk/MAINTAINERS                |  1 -
 board/nxp/ls1012afrdm/MAINTAINERS              | 12 ++++--------
 board/nxp/ls1012aqds/MAINTAINERS               |  1 -
 board/nxp/ls1012ardb/MAINTAINERS               |  3 ---
 board/nxp/ls1043aqds/MAINTAINERS               |  7 -------
 board/nxp/ls1043ardb/MAINTAINERS               |  6 ------
 board/nxp/ls1046aqds/MAINTAINERS               |  7 -------
 board/nxp/ls1046ardb/MAINTAINERS               |  7 -------
 board/nxp/ls1088a/MAINTAINERS                  |  9 ---------
 board/nxp/ls2080aqds/MAINTAINERS               |  4 ----
 board/nxp/ls2080ardb/MAINTAINERS               |  6 ------
 board/nxp/lx2160a/MAINTAINERS                  |  2 --
 board/nxp/mpc837xerdb/MAINTAINERS              |  1 -
 board/nxp/mx6slevk/MAINTAINERS                 |  2 --
 board/nxp/p2041rdb/MAINTAINERS                 |  3 ---
 board/nxp/t104xrdb/MAINTAINERS                 | 13 -------------
 board/nxp/t208xqds/MAINTAINERS                 |  5 -----
 board/nxp/t208xrdb/MAINTAINERS                 |  1 -
 board/phytec/phycore_am68x/MAINTAINERS         |  1 -
 board/polyhex/imx8mp_debix_model_a/MAINTAINERS |  1 -
 board/renesas/blanche/MAINTAINERS              |  1 -
 board/seeed/linkit-smart-7688/MAINTAINERS      |  1 -
 board/sunxi/MAINTAINERS                        |  2 --
 board/toradex/colibri-imx6ull/MAINTAINERS      |  1 -
 board/traverse/ten64/MAINTAINERS               |  1 -
 board/xilinx/zynqmp/MAINTAINERS                |  1 -
 board/zyxel/nsa325/MAINTAINERS                 |  3 ---
 46 files changed, 7 insertions(+), 143 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 341c308e3efc..d8727e6e68c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -234,7 +234,6 @@ ARM BROADCOM BCM283X / BCM27XX
 M:	Matthias Brugger <mbrugger@suse.com>
 M:	Peter Robinson <pbrobinson@gmail.com>
 S:	Maintained
-F:	arch/arm/dts/bcm283*
 F:	arch/arm/mach-bcm283x/
 F:	board/raspberrypi/
 F:	drivers/gpio/bcm2835_gpio.c
diff --git a/board/LaCie/net2big_v2/MAINTAINERS b/board/LaCie/net2big_v2/MAINTAINERS
index 66e82196794e..41a7f07e4a3d 100644
--- a/board/LaCie/net2big_v2/MAINTAINERS
+++ b/board/LaCie/net2big_v2/MAINTAINERS
@@ -1,12 +1,8 @@
 NET2BIG_V2 BOARD
 M:	Simon Guinot <simon.guinot@sequanux.org>
 S:	Maintained
-F:	arch/arm/dts/kirkwood-d2net.dts
 F:	arch/arm/dts/kirkwood-d2net-u-boot.dtsi
-F:	arch/arm/dts/kirkwood-d2net.dtsi
-F:	arch/arm/dts/kirkwood-net2big.dts
 F:	arch/arm/dts/kirkwood-net2big-u-boot.dtsi
-F:	arch/arm/dts/kirkwood-netxbig.dtsi
 F:	board/LaCie/common/
 F:	board/LaCie/net2big_v2/
 F:	include/configs/lacie_kw.h
diff --git a/board/LaCie/netspace_v2/MAINTAINERS b/board/LaCie/netspace_v2/MAINTAINERS
index 03bc7874c164..1e0a50240781 100644
--- a/board/LaCie/netspace_v2/MAINTAINERS
+++ b/board/LaCie/netspace_v2/MAINTAINERS
@@ -1,15 +1,9 @@
 NETSPACE_V2 BOARDS
 M:	Simon Guinot <simon.guinot@sequanux.org>
 S:	Maintained
-F:	arch/arm/dts/kirkwood-is2.dts
 F:	arch/arm/dts/kirkwood-is2-u-boot.dtsi
-F:	arch/arm/dts/kirkwood-ns2-common.dtsi
-F:	arch/arm/dts/kirkwood-ns2.dts
-F:	arch/arm/dts/kirkwood-ns2lite.dts
 F:	arch/arm/dts/kirkwood-ns2lite-u-boot.dtsi
-F:	arch/arm/dts/kirkwood-ns2max.dts
 F:	arch/arm/dts/kirkwood-ns2max-u-boot.dtsi
-F:	arch/arm/dts/kirkwood-ns2mini.dts
 F:	arch/arm/dts/kirkwood-ns2mini-u-boot.dtsi
 F:	arch/arm/dts/kirkwood-ns2-u-boot.dtsi
 F:	board/LaCie/common/
diff --git a/board/Synology/ds116/MAINTAINERS b/board/Synology/ds116/MAINTAINERS
index 8d3cc24fbef4..048ec9f10a1d 100644
--- a/board/Synology/ds116/MAINTAINERS
+++ b/board/Synology/ds116/MAINTAINERS
@@ -1,7 +1,6 @@
 DS116 BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
 S:	Maintained
-F:	arch/arm/dts/armada-385-synology-ds116.dts
 F:	board/Synology/ds116/
 F:	board/Synology/common
 F:	include/configs/ds116.h
diff --git a/board/altera/stratix10-socdk/MAINTAINERS b/board/altera/stratix10-socdk/MAINTAINERS
index 6efd0cfc0560..6192bc917465 100644
--- a/board/altera/stratix10-socdk/MAINTAINERS
+++ b/board/altera/stratix10-socdk/MAINTAINERS
@@ -4,5 +4,4 @@ M:	Dinh Nguyen <dinh.nguyen@intel.com>
 S:	Maintained
 F:	board/altera/stratix10-socdk/
 F:	include/configs/socfpga_stratix10_socdk.h
-F:	configs/socfpga_stratix10_atf_defconfig
 F:	configs/socfpga_stratix10_defconfig
diff --git a/board/atmel/at91sam9260ek/MAINTAINERS b/board/atmel/at91sam9260ek/MAINTAINERS
index aa7898ef7469..28b11243feb5 100644
--- a/board/atmel/at91sam9260ek/MAINTAINERS
+++ b/board/atmel/at91sam9260ek/MAINTAINERS
@@ -9,7 +9,6 @@ F:	configs/at91sam9260ek_nandflash_defconfig
 F:	configs/at91sam9g20ek_2mmc_nandflash_defconfig
 F:	configs/at91sam9g20ek_dataflash_cs0_defconfig
 F:	configs/at91sam9g20ek_dataflash_cs1_defconfig
-F:	configs/at91sam9g20ek_mmc_defconfig
 F:	configs/at91sam9g20ek_2mmc_defconfig
 F:	configs/at91sam9g20ek_nandflash_defconfig
 F:	configs/at91sam9xeek_dataflash_cs0_defconfig
diff --git a/board/beacon/beacon-rzg2m/MAINTAINERS b/board/beacon/beacon-rzg2m/MAINTAINERS
index a4a920a017b0..b28272c58ee0 100644
--- a/board/beacon/beacon-rzg2m/MAINTAINERS
+++ b/board/beacon/beacon-rzg2m/MAINTAINERS
@@ -7,9 +7,6 @@ F:	include/configs/beacon-rzg2m.h
 F:	configs/rzg2_beacon_defconfig
 F:	arch/arm/dts/beacon-renesom-baseboard.dtsi
 F:	arch/arm/dts/beacon-renesom-som.dtsi
-F:	arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts
-F:	arch/arm/dts/r8a774b1-beacon-rzg2n-kit.dts
-F:	arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts
 F:	arch/arm/dts/r8a774a1-beacon-rzg2m-kit-u-boot.dtsi
 F:	arch/arm/dts/r8a774b1-beacon-rzg2n-kit-u-boot.dtsi
 F:	arch/arm/dts/r8a774e1-beacon-rzg2h-kit-u-boot.dtsi
diff --git a/board/embest/mx6boards/MAINTAINERS b/board/embest/mx6boards/MAINTAINERS
index 02756c58b3c8..0ffd4668b42d 100644
--- a/board/embest/mx6boards/MAINTAINERS
+++ b/board/embest/mx6boards/MAINTAINERS
@@ -5,4 +5,3 @@ F:	board/embest/mx6boards/
 F:	include/configs/embestmx6boards.h
 F:	configs/marsboard_defconfig
 F:	configs/riotboard_defconfig
-F:	configs/riotboard_spl_defconfig
diff --git a/board/gardena/smart-gateway-mt7688/MAINTAINERS b/board/gardena/smart-gateway-mt7688/MAINTAINERS
index bbb491c1ce6d..f241d5c3a5e5 100644
--- a/board/gardena/smart-gateway-mt7688/MAINTAINERS
+++ b/board/gardena/smart-gateway-mt7688/MAINTAINERS
@@ -4,5 +4,4 @@ S:	Maintained
 F:	board/gardena/smart-gateway-mt7688
 F:	include/configs/gardena-smart-gateway-mt7688.h
 F:	configs/gardena-smart-gateway-mt7688_defconfig
-F:	configs/gardena-smart-gateway-mt7688-ram_defconfig
 F:	arch/mips/dts/gardena-smart-gateway-mt7688.dts
diff --git a/board/gateworks/gw_ventana/MAINTAINERS b/board/gateworks/gw_ventana/MAINTAINERS
index f9872806c0c5..3d604b725b2c 100644
--- a/board/gateworks/gw_ventana/MAINTAINERS
+++ b/board/gateworks/gw_ventana/MAINTAINERS
@@ -15,7 +15,6 @@ F:	arch/arm/dts/imx6dl-gw553x.dts
 F:	arch/arm/dts/imx6dl-gw560x.dts
 F:	arch/arm/dts/imx6dl-gw5903.dts
 F:	arch/arm/dts/imx6dl-gw5904.dts
-F:	arch/arm/dts/imx6dl-gw5905.dts
 F:	arch/arm/dts/imx6dl-gw5907.dts
 F:	arch/arm/dts/imx6dl-gw5910.dts
 F:	arch/arm/dts/imx6dl-gw5912.dts
@@ -30,7 +29,6 @@ F:	arch/arm/dts/imx6qdl-gw553x.dtsi
 F:	arch/arm/dts/imx6qdl-gw560x.dtsi
 F:	arch/arm/dts/imx6qdl-gw5903.dtsi
 F:	arch/arm/dts/imx6qdl-gw5904.dtsi
-F:	arch/arm/dts/imx6qdl-gw5905.dtsi
 F:	arch/arm/dts/imx6qdl-gw5907.dtsi
 F:	arch/arm/dts/imx6qdl-gw5910.dtsi
 F:	arch/arm/dts/imx6qdl-gw5912.dtsi
@@ -38,17 +36,13 @@ F:	arch/arm/dts/imx6qdl-gw5913.dtsi
 F:	arch/arm/dts/imx6q-gw51xx.dts
 F:	arch/arm/dts/imx6q-gw52xx.dts
 F:	arch/arm/dts/imx6q-gw53xx.dts
-F:	arch/arm/dts/imx6q-gw5400-a.dts
 F:	arch/arm/dts/imx6q-gw54xx.dts
 F:	arch/arm/dts/imx6q-gw551x.dts
 F:	arch/arm/dts/imx6q-gw552x.dts
 F:	arch/arm/dts/imx6q-gw553x.dts
 F:	arch/arm/dts/imx6q-gw560x.dts
-F:	arch/arm/dts/imx6q-gw5901.dts
-F:	arch/arm/dts/imx6q-gw5902.dts
 F:	arch/arm/dts/imx6q-gw5903.dts
 F:	arch/arm/dts/imx6q-gw5904.dts
-F:	arch/arm/dts/imx6q-gw5905.dts
 F:	arch/arm/dts/imx6q-gw5907.dts
 F:	arch/arm/dts/imx6q-gw5910.dts
 F:	arch/arm/dts/imx6q-gw5912.dts
diff --git a/board/ge/bx50v3/MAINTAINERS b/board/ge/bx50v3/MAINTAINERS
index 53a8d88a9043..9dacfaf99974 100644
--- a/board/ge/bx50v3/MAINTAINERS
+++ b/board/ge/bx50v3/MAINTAINERS
@@ -7,8 +7,5 @@ F:	arch/arm/dts/imx6q-b650v3.dts
 F:	arch/arm/dts/imx6q-b850v3.dts
 F:	arch/arm/dts/imx6q-bx50v3*
 F:	board/ge/bx50v3/
-F:	configs/ge_b450v3_defconfig
-F:	configs/ge_b650v3_defconfig
-F:	configs/ge_b850v3_defconfig
 F:	configs/ge_bx50v3_defconfig
 F:	include/configs/ge_bx50v3.h
diff --git a/board/intel/agilex-socdk/MAINTAINERS b/board/intel/agilex-socdk/MAINTAINERS
index fd05e9a4afb3..a90e9e91bb5a 100644
--- a/board/intel/agilex-socdk/MAINTAINERS
+++ b/board/intel/agilex-socdk/MAINTAINERS
@@ -4,7 +4,6 @@ M:	Chee Hong Ang <chee.hong.ang@intel.com>
 S:	Maintained
 F:	board/intel/agilex-socdk/
 F:	include/configs/socfpga_agilex_socdk.h
-F:	configs/socfpga_agilex_atf_defconfig
 F:	configs/socfpga_agilex_defconfig
 
 SOCFPGA BOARD WITH VAB
diff --git a/board/intel/agilex7m-socdk/MAINTAINERS b/board/intel/agilex7m-socdk/MAINTAINERS
index eea2810d3287..c7cf80eb7e1f 100644
--- a/board/intel/agilex7m-socdk/MAINTAINERS
+++ b/board/intel/agilex7m-socdk/MAINTAINERS
@@ -3,7 +3,6 @@ M:	Tien Fong Chee <tien.fong.chee@altera.com>
 M:	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
 S:	Maintained
 F:	arch/arm/dts/socfpga_soc64_u-boot.dtsi
-F:	arch/arm/dts/socfpga_agilex7m*
 F:	arch/arm/mach-socfpga/spl_agilex7m.c
 F:	board/intel/agilex7m-socdk/
 F:	include/configs/socfpga_agilex7m_socdk.h
diff --git a/board/intel/n5x-socdk/MAINTAINERS b/board/intel/n5x-socdk/MAINTAINERS
index ca063a9f3f1d..0ef39964412c 100644
--- a/board/intel/n5x-socdk/MAINTAINERS
+++ b/board/intel/n5x-socdk/MAINTAINERS
@@ -5,5 +5,4 @@ S:	Maintained
 F:	board/intel/n5x-socdk/
 F:	include/configs/socfpga_n5x_socdk.h
 F:	configs/socfpga_n5x_defconfig
-F:	configs/socfpga_n5x_atf_defconfig
 F:	configs/socfpga_n5x_vab_defconfig
diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
index c43f469589dd..2e7f43042ba3 100644
--- a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
+++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
@@ -3,4 +3,3 @@ M:	Jacobe Zang <jacobe.zang@wesion.com>
 S:	Maintained
 F:	configs/khadas-edge2-rk3588s_defconfig
 F:	include/configs/khadas-edge2-rk3588s.h
-F:	arch/arm/dts/rk3588s-khadas-edge2*
diff --git a/board/kontron/sl-mx6ul/MAINTAINERS b/board/kontron/sl-mx6ul/MAINTAINERS
index 9e9dff0361ce..8f23adeeae82 100644
--- a/board/kontron/sl-mx6ul/MAINTAINERS
+++ b/board/kontron/sl-mx6ul/MAINTAINERS
@@ -1,10 +1,9 @@
 Kontron SL/BL i.MX6UL/ULL Boards (N63xx/N64xx)
 M:	Frieder Schrempf <frieder.schrempf@kontron.de>
 S:	Maintained
-F:	arch/arm/dts/imx6ul-kontron-sl*
-F:	arch/arm/dts/imx6ul-kontron-bl*
-F:	arch/arm/dts/imx6ull-kontron-sl*
-F:	arch/arm/dts/imx6ull-kontron-bl*
+F:	arch/arm/dts/imx6ul-kontron-bl-common-u-boot.dtsi
+F:	arch/arm/dts/imx6ul-kontron-bl-u-boot.dtsi
+F:	arch/arm/dts/imx6ull-kontron-bl-u-boot.dtsi
 F:	board/kontron/sl-mx6ul
 F:	configs/kontron-sl-mx6ul_defconfig
 F:	doc/board/kontron/sl-mx6ul.rst
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 47f91d6e81c9..510b7f3f5119 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -18,9 +18,6 @@ MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
-F:	arch/arm/dts/mt8188-u-boot.dtsi
-F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
-F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig
diff --git a/board/mediatek/mt7981/MAINTAINERS b/board/mediatek/mt7981/MAINTAINERS
index e7592a7a548a..b75a5b0bfcfd 100644
--- a/board/mediatek/mt7981/MAINTAINERS
+++ b/board/mediatek/mt7981/MAINTAINERS
@@ -6,5 +6,3 @@ F:	include/configs/mt7981.h
 F:	configs/mt7981_emmc_rfb_defconfig
 F:	configs/mt7981_rfb_defconfig
 F:	configs/mt7981_sd_rfb_defconfig
-F:	configs/mt7981_spim_nand_rfb_defconfig
-F:	configs/mt7981_spim_nor_rfb_defconfig
diff --git a/board/mediatek/mt7986/MAINTAINERS b/board/mediatek/mt7986/MAINTAINERS
index ddc078a567a8..ab09615f0bcf 100644
--- a/board/mediatek/mt7986/MAINTAINERS
+++ b/board/mediatek/mt7986/MAINTAINERS
@@ -6,7 +6,3 @@ F:	include/configs/mt7986.h
 F:	configs/mt7986_rfb_defconfig
 F:	configs/mt7986a_bpir3_emmc_defconfig
 F:	configs/mt7986a_bpir3_sd_defconfig
-F:	configs/mt7986a_emmc_rfb_defconfig
-F:	configs/mt7986a_sd_rfb_defconfig
-F:	configs/mt7986b_emmc_rfb_defconfig
-F:	configs/mt7986b_sd_rfb_defconfig
diff --git a/board/nxp/imx93_evk/MAINTAINERS b/board/nxp/imx93_evk/MAINTAINERS
index 0c542aced873..311e80d1b476 100644
--- a/board/nxp/imx93_evk/MAINTAINERS
+++ b/board/nxp/imx93_evk/MAINTAINERS
@@ -4,6 +4,5 @@ S:	Maintained
 F:	board/nxp/imx93_evk/
 F:	include/configs/imx93_evk.h
 F:	configs/imx93_11x11_evk_defconfig
-F:	configs/imx93_11x11_evk_ld_defconfig
 F:	configs/imx93w_evk_defconfig
 F:	configs/imx93w_evk_inline_ecc_defconfig
diff --git a/board/nxp/ls1012afrdm/MAINTAINERS b/board/nxp/ls1012afrdm/MAINTAINERS
index a69c268e53b7..d931383e65be 100644
--- a/board/nxp/ls1012afrdm/MAINTAINERS
+++ b/board/nxp/ls1012afrdm/MAINTAINERS
@@ -3,15 +3,11 @@ M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1012afrdm/
 F:	include/configs/ls1012afrdm.h
-F:	configs/ls1012afrdm_qspi_defconfig
 F:	configs/ls1012afrdm_tfa_defconfig
-F:	configs/ls1012afrwy_tfa_defconfig
-F:	configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
 
 LS1012AFRWY BOARD
 M:	Pramod Kumar <pramod.kumar_1@nxp.com>
-S:      Maintained
-F:      board/nxp/ls1012afrwy/
-F:      include/configs/ls1012afrwy.h
-F:      configs/ls1012afrwy_qspi_defconfig
-F:	configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig
+S:	Maintained
+F:	include/configs/ls1012afrwy.h
+F:	configs/ls1012afrwy_tfa_defconfig
+F:	configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls1012aqds/MAINTAINERS b/board/nxp/ls1012aqds/MAINTAINERS
index 2178df909929..52bf79ebd6fb 100644
--- a/board/nxp/ls1012aqds/MAINTAINERS
+++ b/board/nxp/ls1012aqds/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1012aqds/
 F:	include/configs/ls1012aqds.h
-F:	configs/ls1012aqds_qspi_defconfig
 F:	configs/ls1012aqds_tfa_defconfig
 F:	configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls1012ardb/MAINTAINERS b/board/nxp/ls1012ardb/MAINTAINERS
index 5dd2858a86c7..dfb852f5f537 100644
--- a/board/nxp/ls1012ardb/MAINTAINERS
+++ b/board/nxp/ls1012ardb/MAINTAINERS
@@ -3,15 +3,12 @@ M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1012ardb/
 F:	include/configs/ls1012ardb.h
-F:	configs/ls1012ardb_qspi_defconfig
 F:	configs/ls1012ardb_tfa_defconfig
 F:	configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
 F:	configs/ls1012a2g5rdb_tfa_defconfig
-F:	configs/ls1012ardb_qspi_SECURE_BOOT_defconfig
 
 LS1012A2G5RDB BOARD
 M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:      Maintained
 F:      board/nxp/ls1012ardb/
 F:      include/configs/ls1012a2g5rdb.h
-F:      configs/ls1012a2g5rdb_qspi_defconfig
diff --git a/board/nxp/ls1043aqds/MAINTAINERS b/board/nxp/ls1043aqds/MAINTAINERS
index daea64483d2a..9e82c2c9f20c 100644
--- a/board/nxp/ls1043aqds/MAINTAINERS
+++ b/board/nxp/ls1043aqds/MAINTAINERS
@@ -3,12 +3,5 @@ M:	Mingkai Hu <mingkai.hu@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1043aqds/
 F:	include/configs/ls1043aqds.h
-F:	configs/ls1043aqds_defconfig
-F:	configs/ls1043aqds_nor_ddr3_defconfig
-F:	configs/ls1043aqds_nand_defconfig
-F:	configs/ls1043aqds_sdcard_ifc_defconfig
-F:	configs/ls1043aqds_sdcard_qspi_defconfig
-F:	configs/ls1043aqds_qspi_defconfig
-F:	configs/ls1043aqds_lpuart_defconfig
 F:	configs/ls1043aqds_tfa_defconfig
 F:	configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls1043ardb/MAINTAINERS b/board/nxp/ls1043ardb/MAINTAINERS
index 4df5940ab713..14ea4d2492f1 100644
--- a/board/nxp/ls1043ardb/MAINTAINERS
+++ b/board/nxp/ls1043ardb/MAINTAINERS
@@ -3,11 +3,5 @@ M:	Mingkai Hu <mingkai.hu@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1043ardb/
 F:	include/configs/ls1043ardb.h
-F:	configs/ls1043ardb_defconfig
-F:	configs/ls1043ardb_nand_defconfig
-F:	configs/ls1043ardb_sdcard_defconfig
 F:	configs/ls1043ardb_tfa_defconfig
 F:	configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
-F:	configs/ls1043ardb_SECURE_BOOT_defconfig
-F:	configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
-F:	configs/ls1043ardb_nand_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls1046aqds/MAINTAINERS b/board/nxp/ls1046aqds/MAINTAINERS
index 792531f7f3ae..86c1c7e2c81f 100644
--- a/board/nxp/ls1046aqds/MAINTAINERS
+++ b/board/nxp/ls1046aqds/MAINTAINERS
@@ -3,12 +3,5 @@ M:	Mingkai Hu <Mingkai.Hu@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1046aqds/
 F:	include/configs/ls1046aqds.h
-F:	configs/ls1046aqds_defconfig
-F:	configs/ls1046aqds_nand_defconfig
-F:	configs/ls1046aqds_sdcard_ifc_defconfig
-F:	configs/ls1046aqds_sdcard_qspi_defconfig
-F:	configs/ls1046aqds_qspi_defconfig
-F:	configs/ls1046aqds_lpuart_defconfig
 F:	configs/ls1046aqds_tfa_defconfig
 F:	configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
-F:	configs/ls1046aqds_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls1046ardb/MAINTAINERS b/board/nxp/ls1046ardb/MAINTAINERS
index bb5f6a64d7b4..ef5f7002002e 100644
--- a/board/nxp/ls1046ardb/MAINTAINERS
+++ b/board/nxp/ls1046ardb/MAINTAINERS
@@ -4,13 +4,6 @@ S:	Maintained
 F:	board/nxp/ls1046ardb/
 F:	board/nxp/ls1046ardb/ls1046ardb.c
 F:	include/configs/ls1046ardb.h
-F:	configs/ls1046ardb_qspi_defconfig
-F:	configs/ls1046ardb_qspi_spl_defconfig
-F:	configs/ls1046ardb_sdcard_defconfig
-F:	configs/ls1046ardb_emmc_defconfig
 F:	configs/ls1046ardb_tfa_defconfig
 F:	configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
-F:	configs/ls1046ardb_SECURE_BOOT_defconfig
-F:	configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
-F:	configs/ls1046ardb_qspi_SECURE_BOOT_defconfig
 F:	doc/board/nxp/ls1046ardb.rst
diff --git a/board/nxp/ls1088a/MAINTAINERS b/board/nxp/ls1088a/MAINTAINERS
index 85f38fcf0c72..412ddc54599b 100644
--- a/board/nxp/ls1088a/MAINTAINERS
+++ b/board/nxp/ls1088a/MAINTAINERS
@@ -3,8 +3,6 @@ M:	Ashish Kumar <Ashish.Kumar@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1088a/
 F:	include/configs/ls1088ardb.h
-F:	configs/ls1088ardb_qspi_defconfig
-F:	configs/ls1088ardb_sdcard_qspi_defconfig
 F:	configs/ls1088ardb_tfa_defconfig
 F:	configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
 
@@ -13,23 +11,16 @@ M:	Ashish Kumar <Ashish.Kumar@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1088a/
 F:	include/configs/ls1088aqds.h
-F:	configs/ls1088aqds_qspi_defconfig
-F:	configs/ls1088aqds_sdcard_qspi_defconfig
-F:	configs/ls1088aqds_defconfig
-F:	configs/ls1088aqds_sdcard_ifc_defconfig
 F:	configs/ls1088aqds_tfa_defconfig
 
 LS1088AQDS_QSPI_SECURE_BOOT BOARD
 M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
-F:	configs/ls1088aqds_qspi_SECURE_BOOT_defconfig
 
 LS1088ARDB_QSPI_SECURE_BOOT BOARD
 M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
-F:	configs/ls1088ardb_qspi_SECURE_BOOT_defconfig
 
 LS1088ARDB_SD_SECURE_BOOT BOARD
 M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
-F:	configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls2080aqds/MAINTAINERS b/board/nxp/ls2080aqds/MAINTAINERS
index 3659cec4cd86..9328a084e41e 100644
--- a/board/nxp/ls2080aqds/MAINTAINERS
+++ b/board/nxp/ls2080aqds/MAINTAINERS
@@ -3,11 +3,7 @@ M:	Priyanka Jain <priyanka.jain@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
 F:	board/nxp/ls2080aqds/
-F:	board/nxp/ls2080a/ls2080aqds.c
 F:	include/configs/ls2080aqds.h
-F:	configs/ls2080aqds_defconfig
 F:	configs/ls2080aqds_nand_defconfig
 F:	configs/ls2080aqds_qspi_defconfig
-F:	configs/ls2080aqds_sdcard_defconfig
 F:	configs/ls2088aqds_tfa_defconfig
-F:	configs/ls2080aqds_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls2080ardb/MAINTAINERS b/board/nxp/ls2080ardb/MAINTAINERS
index 867ebe99cace..8341609b6e99 100644
--- a/board/nxp/ls2080ardb/MAINTAINERS
+++ b/board/nxp/ls2080ardb/MAINTAINERS
@@ -3,30 +3,24 @@ M:	Priyanka Jain <priyanka.jain@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
 F:	board/nxp/ls2080ardb/
-F:	board/nxp/ls2080a/ls2080ardb.c
 F:	include/configs/ls2080ardb.h
-F:	configs/ls2080ardb_defconfig
 F:	configs/ls2080ardb_nand_defconfig
 
 LS2088A_QSPI-boot BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	configs/ls2088ardb_qspi_defconfig
 F:	configs/ls2088ardb_tfa_defconfig
 F:	configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
 
 LS2081ARDB BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
-F:	configs/ls2081ardb_defconfig
 
 LS2080A_SECURE_BOOT BOARD
 M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
-F:	configs/ls2080ardb_SECURE_BOOT_defconfig
 
 LS2088A_QSPI_SECURE_BOOT BOARD
 M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
-F:	configs/ls2088ardb_qspi_SECURE_BOOT_defconfig
diff --git a/board/nxp/lx2160a/MAINTAINERS b/board/nxp/lx2160a/MAINTAINERS
index abdac1372d28..945366a99861 100644
--- a/board/nxp/lx2160a/MAINTAINERS
+++ b/board/nxp/lx2160a/MAINTAINERS
@@ -19,7 +19,6 @@ LX2160AQDS BOARD
 M:	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	board/nxp/lx2160a/eth_lx2160aqds.h
 F:	include/configs/lx2160aqds.h
 F:	configs/lx2160aqds_tfa_defconfig
 F:	arch/arm/dts/fsl-lx2160a-qds.dts
@@ -33,7 +32,6 @@ LX2162AQDS BOARD
 M:	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	board/nxp/lx2160a/eth_lx2162aqds.h
 F:	include/configs/lx2162aqds.h
 F:	configs/lx2162aqds_tfa_defconfig
 F:	arch/arm/dts/fsl-lx2162a-qds.dts
diff --git a/board/nxp/mpc837xerdb/MAINTAINERS b/board/nxp/mpc837xerdb/MAINTAINERS
index 9b05a6ad4217..cc0a6acd8c38 100644
--- a/board/nxp/mpc837xerdb/MAINTAINERS
+++ b/board/nxp/mpc837xerdb/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/nxp/mpc837xerdb/
 F:	include/configs/MPC837XERDB.h
 F:	configs/MPC837XERDB_defconfig
-F:	configs/MPC837XERDB_SLAVE_defconfig
diff --git a/board/nxp/mx6slevk/MAINTAINERS b/board/nxp/mx6slevk/MAINTAINERS
index 4410358ea08c..6b8d5f2ca2c8 100644
--- a/board/nxp/mx6slevk/MAINTAINERS
+++ b/board/nxp/mx6slevk/MAINTAINERS
@@ -5,5 +5,3 @@ S:	Maintained
 F:	board/nxp/mx6slevk/
 F:	include/configs/mx6slevk.h
 F:	configs/mx6slevk_defconfig
-F:	configs/mx6slevk_spl_defconfig
-F:	configs/mx6slevk_spinor_defconfig
diff --git a/board/nxp/p2041rdb/MAINTAINERS b/board/nxp/p2041rdb/MAINTAINERS
index f0d5c1192ac6..d139dd518747 100644
--- a/board/nxp/p2041rdb/MAINTAINERS
+++ b/board/nxp/p2041rdb/MAINTAINERS
@@ -4,8 +4,5 @@ S:	Maintained
 F:	board/nxp/p2041rdb/
 F:	include/configs/P2041RDB.h
 F:	configs/P2041RDB_defconfig
-F:	configs/P2041RDB_NAND_defconfig
 F:	configs/P2041RDB_SDCARD_defconfig
-F:	configs/P2041RDB_SECURE_BOOT_defconfig
 F:	configs/P2041RDB_SPIFLASH_defconfig
-F:	configs/P2041RDB_SRIO_PCIE_BOOT_defconfig
diff --git a/board/nxp/t104xrdb/MAINTAINERS b/board/nxp/t104xrdb/MAINTAINERS
index 5542530698d9..d0b5709df81f 100644
--- a/board/nxp/t104xrdb/MAINTAINERS
+++ b/board/nxp/t104xrdb/MAINTAINERS
@@ -3,24 +3,11 @@ M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
 F:	board/nxp/t104xrdb/
 F:	include/configs/T104xRDB.h
-F:	configs/T1040RDB_defconfig
-F:	configs/T1040RDB_NAND_defconfig
-F:	configs/T1040RDB_SPIFLASH_defconfig
-F:	configs/T1040D4RDB_defconfig
-F:	configs/T1040D4RDB_NAND_defconfig
-F:	configs/T1040D4RDB_SPIFLASH_defconfig
-F:	configs/T1042RDB_defconfig
 F:	configs/T1042D4RDB_defconfig
 F:	configs/T1042D4RDB_NAND_defconfig
 F:	configs/T1042D4RDB_SPIFLASH_defconfig
-F:	configs/T1042RDB_PI_defconfig
-F:	configs/T1042RDB_PI_NAND_defconfig
-F:	configs/T1042RDB_PI_SPIFLASH_defconfig
 
 T1040RDB_SDCARD BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
-F:	configs/T1040RDB_SDCARD_defconfig
-F:	configs/T1040D4RDB_SDCARD_defconfig
 F:	configs/T1042D4RDB_SDCARD_defconfig
-F:	configs/T1042RDB_PI_SDCARD_defconfig
diff --git a/board/nxp/t208xqds/MAINTAINERS b/board/nxp/t208xqds/MAINTAINERS
index 56911e8fd154..3c94352ec997 100644
--- a/board/nxp/t208xqds/MAINTAINERS
+++ b/board/nxp/t208xqds/MAINTAINERS
@@ -8,11 +8,6 @@ F:	configs/T2080QDS_NAND_defconfig
 F:	configs/T2080QDS_SDCARD_defconfig
 F:	configs/T2080QDS_SPIFLASH_defconfig
 F:	configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
-F:	configs/T2081QDS_defconfig
-F:	configs/T2081QDS_NAND_defconfig
-F:	configs/T2081QDS_SDCARD_defconfig
-F:	configs/T2081QDS_SPIFLASH_defconfig
-F:	configs/T2081QDS_SRIO_PCIE_BOOT_defconfig
 
 T2080QDS_SECURE_BOOT BOARD
 M:	Ruchika Gupta <ruchika.gupta@nxp.com>
diff --git a/board/nxp/t208xrdb/MAINTAINERS b/board/nxp/t208xrdb/MAINTAINERS
index db58c79c2544..aa70c2424b5a 100644
--- a/board/nxp/t208xrdb/MAINTAINERS
+++ b/board/nxp/t208xrdb/MAINTAINERS
@@ -7,7 +7,6 @@ F:	configs/T2080RDB_defconfig
 F:	configs/T2080RDB_NAND_defconfig
 F:	configs/T2080RDB_SDCARD_defconfig
 F:	configs/T2080RDB_SPIFLASH_defconfig
-F:	configs/T2080RDB_SRIO_PCIE_BOOT_defconfig
 F:	configs/T2080RDB_revD_defconfig
 F:	configs/T2080RDB_revD_NAND_defconfig
 F:	configs/T2080RDB_revD_SDCARD_defconfig
diff --git a/board/phytec/phycore_am68x/MAINTAINERS b/board/phytec/phycore_am68x/MAINTAINERS
index 5e175fdb9efe..ca61746f244b 100644
--- a/board/phytec/phycore_am68x/MAINTAINERS
+++ b/board/phytec/phycore_am68x/MAINTAINERS
@@ -3,7 +3,6 @@ M:	Dominik Haller <d.haller@phytec.de>
 L:	upstream@lists.phytec.de
 W:	https://www.phytec.eu/en/produkte/system-on-modules/phycore-am68x-tda4x/
 S:	Maintained
-F:	arch/arm/dts/k3-am68-phycore-som-ddr4-4gb.dtsi
 F:	arch/arm/dts/k3-am68-phyboard-izar-u-boot.dtsi
 F:	arch/arm/dts/k3-am68-phycore-som-binman.dtsi
 F:	arch/arm/dts/k3-am68-r5-phycore-som-4gb.dts
diff --git a/board/polyhex/imx8mp_debix_model_a/MAINTAINERS b/board/polyhex/imx8mp_debix_model_a/MAINTAINERS
index d3afa91c1188..0e07186413ae 100644
--- a/board/polyhex/imx8mp_debix_model_a/MAINTAINERS
+++ b/board/polyhex/imx8mp_debix_model_a/MAINTAINERS
@@ -1,7 +1,6 @@
 DEBIX MODEL A BOARD (i.MX8M Plus)
 M:	Gilles Talis <gilles.talis@gmail.com>
 S:	Maintained
-F:	arch/arm/dts/imx8mp-debix-model-a.dts
 F:	arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
 F:	board/polyhex/imx8mp_debix_model_a/
 F:	include/configs/imx8mp_debix_model_a.h
diff --git a/board/renesas/blanche/MAINTAINERS b/board/renesas/blanche/MAINTAINERS
index 39fb93ed0836..c6d70a78ce69 100644
--- a/board/renesas/blanche/MAINTAINERS
+++ b/board/renesas/blanche/MAINTAINERS
@@ -2,7 +2,6 @@ BLANCHE BOARD
 M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 M:	Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
 S:	Maintained
-F:	arch/arm/dts/r8a7792*
 F:	board/renesas/blanche/
 F:	configs/blanche_defconfig
 F:	include/configs/blanche.h
diff --git a/board/seeed/linkit-smart-7688/MAINTAINERS b/board/seeed/linkit-smart-7688/MAINTAINERS
index f2186c1b9d72..5f24c9cecb57 100644
--- a/board/seeed/linkit-smart-7688/MAINTAINERS
+++ b/board/seeed/linkit-smart-7688/MAINTAINERS
@@ -4,5 +4,4 @@ S:	Maintained
 F:	board/seeed/linkit-smart-7688
 F:	include/configs/linkit-smart-7688.h
 F:	configs/linkit-smart-7688_defconfig
-F:	configs/linkit-smart-7688-ram_defconfig
 F:	arch/mips/dts/linkit-smart-7688.dts
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 775d0f7ae83c..df745f146494 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -50,10 +50,8 @@ F:	configs/Bananapi_defconfig
 F:	configs/Bananapro_defconfig
 F:	configs/i12-tvbox_defconfig
 F:	configs/Linksprite_pcDuino3_defconfig
-F:	configs/Linksprite_pcDuino3_fdt_defconfig
 F:	configs/Orangepi_defconfig
 F:	configs/Orangepi_mini_defconfig
-F:	configs/qt840a_defconfig
 F:	configs/Wits_Pro_A20_DKT_defconfig
 F:	include/configs/sun8i.h
 F:	configs/sun8i_a23_evb_defconfig
diff --git a/board/toradex/colibri-imx6ull/MAINTAINERS b/board/toradex/colibri-imx6ull/MAINTAINERS
index 6c93e35cc65f..1ceb1c8eb1b3 100644
--- a/board/toradex/colibri-imx6ull/MAINTAINERS
+++ b/board/toradex/colibri-imx6ull/MAINTAINERS
@@ -9,7 +9,6 @@ F:	arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi
 F:	arch/arm/dts/imx6ull-colibri-eval-v3.dts
 F:	arch/arm/dts/imx6ull-colibri-eval-v3.dtsi
 F:	arch/arm/dts/imx6ull-colibri-nonwifi.dtsi
-F:	arch/arm/dts/imx6ull-colibri-u-boot.dtsi
 F:	board/toradex/colibri-imx6ull/
 F:	board/toradex/common/
 F:	configs/colibri-imx6ull_defconfig
diff --git a/board/traverse/ten64/MAINTAINERS b/board/traverse/ten64/MAINTAINERS
index 7b53e8793858..590327b8d829 100644
--- a/board/traverse/ten64/MAINTAINERS
+++ b/board/traverse/ten64/MAINTAINERS
@@ -1,7 +1,6 @@
 TEN64 BOARD
 M:	Mathew McBride <matt@traverse.com.au>
 S:	Maintained
-F:	arch/arm/dts/fsl-ls1088a-ten64.dts
 F:	board/traverse/ten64/
 F:	board/traverse/common/
 F:	include/configs/ten64.h
diff --git a/board/xilinx/zynqmp/MAINTAINERS b/board/xilinx/zynqmp/MAINTAINERS
index 8bc50e37e485..dd585bae790b 100644
--- a/board/xilinx/zynqmp/MAINTAINERS
+++ b/board/xilinx/zynqmp/MAINTAINERS
@@ -8,4 +8,3 @@ F:	board/xilinx/common/
 F:	board/xilinx/zynqmp/
 F:	include/configs/xilinx_zynqmp*
 F:	configs/xilinx_zynqmp*
-F:	configs/avnet_ultra96_rev1_defconfig
diff --git a/board/zyxel/nsa325/MAINTAINERS b/board/zyxel/nsa325/MAINTAINERS
index 013cb84b99d2..4a84d2437c3c 100644
--- a/board/zyxel/nsa325/MAINTAINERS
+++ b/board/zyxel/nsa325/MAINTAINERS
@@ -1,9 +1,6 @@
 NSA325 BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
 S:	Maintained
-F:	arch/arm/dts/kirkwood-6282.dtsi
-F:	arch/arm/dts/kirkwood-nsa325.dts
-F:	arch/arm/dts/kirkwood-nsa3x0-common.dtsi
 F:	board/zyxel/nsa325/
 F:	include/configs/nsa325.h
 F:	configs/nsa325_defconfig
-- 
2.43.0

