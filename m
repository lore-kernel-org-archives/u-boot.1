Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A56CC6B2D
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 02:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9FC2608CE;
	Thu, 15 Oct 2026 02:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6jR-oglj4Tiv; Thu, 15 Oct 2026 02:35:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B8F7E608E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792031755;
	b=Op1UbKQ5U5icUrfXwPEKHTJAjcjhDmYch+bFLCaX2upu7IebOKiRChjuNAJzSi+eElWD
	 CjZQWWkHj6i7L9r3d2Xv3kB23Nx0cI/b3MwcfaQYNKd9dJd8DioUrfR7VK2fCR07ugcQg
	 2DR1AOP7KKlwtncILQngN67oTlMmcXcI+xedyIZTqbhXHluts2JU05dD2/o1niABoS9Z9
	 u1RzJgmRQGdDYPBIkKq5JuUttalaMtHoERxBCjQPQ4bD8xz/ldF61RwU9iMzuvN1mdWpM
	 Qoo4TIx5qDHP7SNhNTRQ+WLI3rRfLKABKDV/gA9oGTEESF+sbXp/o0SUBrD0Z252wmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792031755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:Content-Language:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oq1nka39wwD3ZQh7maUBHtvLqsctjl3bzMH9538anCY=;
	b=U9rfYblSI/jU5xYxkXe1/WVGPauC2Brez4nnzN+MJzyyjkDvgCD1IkWaakmcuJjQID8n
	 gaFF07R713aFbvBtjMTGLM9ZHBuWvF+eddwClZsO+FgIkqAOCiYuJG9mtpuzD/LgFc6uc
	 /dWdX0K77T+WyRS5ioHm7SWbKGT0LGmSiuq6uFQoUxchZkTlchBYkaEJ7xf22baWteXcl
	 jAJt2SsjmVMagoOFx+8J3ZBL6QAB1YV90mxvOIhH6p8mAiJs/SDeDa+hVk8J9seROaAxB
	 oD/hkRhPl6h5rQM4FZVyjxpsHJJcTZaEhfvUOghKxyvxU0P7jGJ6Sqa2zt88IvrnECQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V9vbS+9K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792031755;
	bh=oq1nka39wwD3ZQh7maUBHtvLqsctjl3bzMH9538anCY=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gMdlWERXkemXUS/2oSRuBT+Wp9DMh1mLls06V7Sx2yrP/+0Svs9MhbJEE9pA0Ow9S
	 A/fEDmMlkjhtLycrWftHWLp0kXqCnGYKaROlLceYsB66Hlez3WgjykOLDATClLgmaV
	 e6vMMlUh+M9S49NFBMHMD61wu8IfIHS8MiY1YAkUZOzUuBN43qxVPw8nU/F0lwm+mH
	 yDQ70pJt9UM2vWIt99PKlMWxIR/hQoA7p8mi/MF4BehrGhCzdn8S3mH+7E/tMvYTSt
	 mMMyNDcGyTvOI1o6c9/QwEhmAjBKWnkE87wMpHGzQn75yQ8VXqa2yi2uG9TuvGZeJS
	 9p5CNvsuMyM5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8F7E608E7;
	Thu, 15 Oct 2026 02:35:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF875255
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D16C36077F
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:44:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ig5Z4Eb8b-TX for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 01:44:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1391C60767
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792028685;
 b=QNwhL03afdpCl9QxVQ0mJL3X//11VaW5aDa1Ns3LshiUdF5ziMsBKV6F+Fj9GcvWGkkj
 YvaNX7QgUz82nbswnLTKPQRm8JVt86dzmsOI6iSX9DOf/e2CYnkRi9YdAJBRE61pHwrBR
 yLiitWM2IXLSB0gRl2NXJKVCMjCkstWTVvc99wNjC6Hx0l/IGEAAzsHx1Ou6Be/xYPjcT
 SI5YLQVpTh/ZVSgL/WlsuC3g6RVaj2kJFcorYhvUTnJ3r5D4lKEdpRxY72D/xktuWz21S
 0d9yEQNN+nwrXES/OHU0AcYGkIdIHgO/CQ8J791ApJuwcg+o8beQ6sy+QmN9KrAcxnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792028685;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:To:Cc:Content-Language:
 Content-Type:Content-Transfer-Encoding;
 bh=oq1nka39wwD3ZQh7maUBHtvLqsctjl3bzMH9538anCY=;
 b=cnhKUI0dSfPVQfS+JmDBRFViOFCCWNnDmT/NRqaLC4XYG+YBnSkarE6ld4vHiwN5N9Kt
 oTKG8UIuCqy/8FKX1PcxM/HCh9pfNaiiaPv/AtTU7B9tN/cn/8jUBY+jXydeWxr37KPHE
 K9QebOT3Hj7pR3TDIVf/lz8izcL+0rWwrrqYN18IfxSRZHlhL8eSpIbC9+85sDhAKCpLu
 3wC1CkG5s2SBtLnzNDspxbPZvbahLlkhxviS5WWXkEXKOfls6rfKwMiJMTtno1i+Tb/gv
 umwrU+0YEyoGXMLP/+mYZ7k75A4TJo3SiRpQTg9mz93WEn5nHD6SvjU8jijgebpxujw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=V9vbS+9K; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=V9vbS+9K
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1391C60767
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:44:44 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so2398781a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792028684; x=1792633484;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oq1nka39wwD3ZQh7maUBHtvLqsctjl3bzMH9538anCY=;
 b=V9vbS+9Kgy8JQUBurZgedLAGHU6ltuAPQ3qfwyZNDEwdpFk6K+Wmg1NIXyhWpPzEI9
 0WgVTtQgIEhBHuZ5WZn14CZcPNFxU+OaB9xW1VRDapWKY8pS0W395xYwoeUYey5mpHE6
 bqhv8GWaXYG+l+/2BtQnBRMDSDZSX7gmDngBCyL29l85XQ3PdDUVjRJd9TGhsKW11qUv
 s/lJWhZSGSyCURWXv8Xr3DOmrXNQuJqQUc9i64sqb8IwxFQLL4E9M0hG8Yr+w9Q/Uvwn
 uVcvrUi/04IH4SVAdWJPT2xudR2u8OyTR42Y95u1xqcfHS7Ree3sCG1UtvUzCDCsKsdB
 vRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792028684; x=1792633484;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oq1nka39wwD3ZQh7maUBHtvLqsctjl3bzMH9538anCY=;
 b=h4n9Aygez4uWHBLApwzSHQOR5PBqip9eMpYMXoVyDDlz9lJY3SoybaSBe8ntgl5xbF
 fDbzvsKKU+xZ7HrRHaEA+AKD10wwrbfejr1/Bs10eYM52l6zWV3oeDgqDAiCRpnnNgC7
 K6rV77VRlmYgqA5ONLgfFy7nw1AryoYy2HcmjfAY8UXOXMblkdjzLq86+PHEcqrMQE/x
 C3sOgcWmcZcZeEtYz0kdYPnkgx8bQGU1rpxIc2clRYv/0qKcQxx/5EfQ+NgT++6gsTUA
 N42EZSX+F9pfFpQH1LPdBVBoncIj5HmZKG2mc2GfW9dTuv2gfMb3kXle2urgnEkaFJCx
 TrmA==
X-Gm-Message-State: AFq9FYI5tkehKFb/h5Zj1oZ7wU09hVUl2eu458xQZhn8+SN5tmiKoMp7
 lA5oA9GeGVeOVWShQTl9kvNp+DUyziqRySkDLPI9V+B4PWd4uo4ACYFXN79fB2pKKjU=
X-Gm-Gg: AYBFou3mHueNjwd+g+A96i2KZnRzWmzxUkOFWMf2IlOsx2LI0Vd0dERMECbJn9KkkM3
 6jEtfZreStT41fO8lyY5RNgMbkMaXXiwllwJEgRh7MVLKL8T/O9K1mxGhjjAWVOKMZiRF3MEPR8
 xEphtI1S1ZWjL3Ges811IimEfiH9psRKooHr2cuPkDKBXx4pn2bSP0VNj2Hqf10FLlBsLV+P1Ce
 MyQkqMV3XOvqr0GXlazogo/Q6ep6dR0pYD60eiIHXCUAz7vNR/zTvADdwwrdGDECUeC+DfPJgcI
 mYWLGQbA03Vc+qgEi+/T7d5ipQyeDUdm5dJNzqC/xM+FSm9nnvj1uGLcYlKxj+lJ/kXgbDw6RRT
 qh+AnZpcVK0dw993Ik/Nqw5IYfGp31SFAavhVkdc8l6YPfbolSdwThXpqVqROpf1KuxIER3jK67
 837ZLnkiN05gjCPBSh3vJ1lG3WdaBiKX2mmHWymDTMHupH7JF9nkIND7O4tQUkM/NHr5vbc/Xo
X-Received: by 2002:a17:90b:4b85:b0:3a0:f4ee:d2a6 with SMTP id
 98e67ed59e1d1-3ab3ac54b32mr14815242a91.19.1792028683816; 
 Wed, 14 Oct 2026 18:44:43 -0700 (PDT)
Received: from [0.0.0.0] ([20.89.104.82]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac92a43d98sm1077387a91.0.2026.10.14.18.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 18:44:42 -0700 (PDT)
Message-ID: <cc2ffcb6-167d-4e61-bd46-d16ff0319917@gmail.com>
Date: Thu, 15 Oct 2026 09:44:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH v2 0/2] net: add SpacemiT K1 EMAC support
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Eric Chung <eric.chung@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, James Hilliard <james.hilliard1@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Zixian Zeng <sycamoremoon376@gmail.com>,
 Dave Klotz <DaveWK225@protonmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 02:35:50 +0000
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

This series adds support for the Ethernet MACs integrated in
the SpacemiT K1 SoC, which includes adding a k1_emac driver with
MDIO and PHYLIB support for RGMII and RMII operation, enabling it
in the k1 defconfig.

The k1_emac driver in series draws upon Vivian Wang's work [1]. To make it
simple and working, driver which using small ring-buffers operates primarily
on polling and only implements basic functions.

Tested on both Banana Pi F3 Ethernet ports with RTL8211F PHYs
at 1000 Mbps full duplex, and tested command: dhcp, ping, tftp, etc.

[1]: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn/

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Changes in v2:
- Patch 1: Validate the full DMA range, not only the start address, in
   k1_emac_dma32() (suggested by Dave Klotz)
- Patch 1: Add Tested-by from Dave Klotz
- Drop the MAINTAINERS patch, as the top-level "RISC-V SPACEMIT" entry
   already covers the driver via its N:/K: patterns (suggested by Yixun Lan)
- Link to v1: https://patch.msgid.link/20261002-b4-k1-emac-v1-0-e1b6806b018a@gmail.com

---
Zixian Zeng (2):
       net: k1: add Ethernet MAC driver
       configs: k1: enable Ethernet support

  configs/spacemit_k1_defconfig  |   6 +
  drivers/net/Kconfig            |   1 +
  drivers/net/Makefile           |   1 +
  drivers/net/spacemit/Kconfig   |  15 +
  drivers/net/spacemit/Makefile  |   3 +
  drivers/net/spacemit/k1_emac.c | 957 +++++++++++++++++++++++++++++++++++++++++
  6 files changed, 983 insertions(+)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20260926-b4-k1-emac-fa5f2b146f38

Best regards,
--
Zixian Zeng <sycamoremoon376@gmail.com>


