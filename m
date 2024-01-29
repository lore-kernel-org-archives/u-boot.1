Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C162C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 15:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 504EE87C3B;
	Mon, 29 Jan 2024 16:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OSxqRBrL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1AA487C3B; Mon, 29 Jan 2024 16:18:09 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A9F8796E
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 16:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33aed096cb3so897601f8f.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 07:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541487; x=1707146287; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IIxYiNWI7nBCqmtshTAlJS8MByWZ8SulVDF0Q1zvXl8=;
 b=OSxqRBrLJFxJDiU+FUyL4bybEkx0rqDrigm1FuHN4GuVtBMAAS7FLtNFwyP0hopyuO
 j+6iC5HhqLbdHfPXUVI8dSs/HbITTvFPUNWDqB+u9I9QG0TIC9QvWEmo87oTk6jjATvs
 AbbvimAwFeOHqKvPYhRdPZVEOyPZw/10Csan+rqn8ROX9g8vV/gm7HTku4+t1B86QGfZ
 y+iLIWXlQqL+cUE1rOZIobIyYWI+B/cPmTnBGjhyh1+13Rt/9LDw7ChDnbLoevguu6eP
 09ZlNFdR3JMhqdsSlCxqh/s92w/HcWvA1M9Nh8QQSAvrmoDx6CCsg39WA2hB+4wlUZww
 h5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541487; x=1707146287;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IIxYiNWI7nBCqmtshTAlJS8MByWZ8SulVDF0Q1zvXl8=;
 b=ePVwdp5VuIubiq5Ai/nqovnpNuCd547D7SAV9tOlhpTPT4Ay53KLONtCFaQIUbx/ee
 WxON6JER225v7VEkC52v4YeXtlPaOFPLyFODD+ZXPYXli4E6V2OIkqHuKP50bqmVymbc
 xa3UbbQkD5wGfA91JyimfepPV0clyNTK/RU0QXdGCwOuP1O2TVgJ1Futg7/InYP9v1b9
 stTdBWMP3jrnxQmIyMi7P712PedM5uH50Njd2v26o04GIkH73Z94SI2icErqk7KdMImu
 dDuXknBBBdw3RcIiZyvpUlinxQidsCAVY3rYW3rmE/dgxC9BfSzd8AuMaZ2Rnz6G+WEg
 S9Eg==
X-Gm-Message-State: AOJu0Yx5BPNNh2LMbdKR7EvgHsIgCNVzGIcYO67L7adA82ag2aTqyIAD
 5T8u6WbbBWSC651bpEmcELybaW9rJhk5q+F0LK432mv/GKOLa2e62ooBtcYxTvfej5Ehz0sVW1B
 sJGKG9w==
X-Google-Smtp-Source: AGHT+IHZXILRiw6cQWkiU8zwXrHT1a9F+zDp5XoBveMW4ssBEKpgljUCnFOmO99qe0GJbgqU17d9vA==
X-Received: by 2002:a5d:698f:0:b0:33a:e6cf:f559 with SMTP id
 g15-20020a5d698f000000b0033ae6cff559mr3395127wru.39.1706541487041; 
 Mon, 29 Jan 2024 07:18:07 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 f7-20020a5d58e7000000b0033922f918f2sm8312665wrd.64.2024.01.29.07.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 07:18:06 -0800 (PST)
Date: Mon, 29 Jan 2024 18:18:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: agendin@matrox.com
Cc: u-boot@lists.denx.de
Subject: [bug report] cmd: mbr: Allow 4 MBR partitions without need for
 extended
Message-ID: <5d4ac31b-37c4-47dc-9a3b-0ca4fe29baaa@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello Alexander Gendin,

The patch 04291ee0aba6: "cmd: mbr: Allow 4 MBR partitions without
need for extended" from Oct 9, 2023, leads to the following Smatch
static checker warning:

	test/cmd/mbr.c:243 mbr_test_run()
	warn: sizeof(NUMBER)?

test/cmd/mbr.c
    233         ulong mbr_wa, ebr_wa, ra, ebr_blk, mbr_parts_max;
    234         struct udevice *dev;
    235         ofnode root, node;
    236 
    237         /* Enable the mmc6 node for this test */
    238         root = oftree_root(oftree_default());
    239         node = ofnode_find_subnode(root, "mmc6");
    240         ut_assert(ofnode_valid(node));
    241         ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
    242 
--> 243         mbr_parts_max = sizeof('\0') + 2 +
                                       ^^^
You probably wanted this to a readable way to explain that we are
leaving space for the NUL char, however this size is 4 not 1.  (I guess
this is from type promotion?)

    244                 strlen(mbr_parts_header) +
    245                 strlen(mbr_parts_p1) +
    246                 strlen(mbr_parts_p2) +
    247                 strlen(mbr_parts_p3) +
    248                 max(strlen(mbr_parts_p4), strlen(mbr_parts_p5)) +
    249                 strlen(mbr_parts_tail);
    250         ut_assertf(sizeof(mbr_parts_buf) >= mbr_parts_max, "Buffer avail: %ld; buffer req: %ld\n",
    251                 sizeof(mbr_parts_buf), mbr_parts_max);
    252 

regards,
dan carpenter
