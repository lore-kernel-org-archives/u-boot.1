Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F6606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kgozkBzA;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bBKSoWC3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4530C4081B;
	Tue,  3 Nov 2026 13:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bANyIPwNp31U; Tue,  3 Nov 2026 13:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 594894081C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711128;
	b=Ptb9IOYh9whVY/hUV6muFR6UIGQFOTIqo7lzjVAtknj5CgL3MvuY2fML7zXOcArvS0mt
	 zxys+StwohtQC/+wNpL7DDO0MqopjUHtSYwaEcHEQvDJ4AI/UTKKjzEoP7SmEO8QSKMrr
	 IgxBZzkYYfyWkpARcCpAxc5DTXblzYveQs6B8ERT9lxRcXsJktlWroWvYwJZ8/2zlUOzJ
	 ZTWAWwuLQWnm0WAXmHqA/Np0VODd1FvCZJcEhPJFjrT1BuLuaCMgFBOwozD6Eaqxs7hXz
	 m2LwP8/4JgbMuKXudBowZSh6AEgTo7K9GvGXCraq7pq5iXYGqhIw8ot47lEg9M3vnFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711128;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=opxJgXCrn695wi7g+aO45tYt2qP/f5avVsRx9DorV78=;
	b=eWtZ/Y2zCKawcg5oM5T1eamOnKYjhowhTv5XaKczqRQ0GTINCF8+h+Fdm7E1NLgoGsjv
	 nnMdlQKaSazWfuWP/pW60dIBG3TMn1qyhDyr5KButitp+jFFilx+54xON55ml7Oq457uv
	 Dm3CAk5Jt6Osbz6CBPlGuxfG0tjoKdJLp5TP/hL+qOfms2ZsKDux/wvzG1ZS8Un+MFjYw
	 l4Skt4l16xAWwNJ9/beZUASQPbBmoTyn6zdnaY3+Ivj9wMICCoPzDGjMKWtidQVLxQYJr
	 UuVnWxmY0MeK2sCRZg+gK4xzn8AsZFxMY2fWUKCl2v7OC4npGfUvzo/Q1UPIAHvhezQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711128;
	bh=opxJgXCrn695wi7g+aO45tYt2qP/f5avVsRx9DorV78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kgozkBzAByZX6CFRNt1K19l3+E6QJUg5qnMa3nxMSsVVIo6/ixWbpvmPwcDSlSQmT
	 Ut7Ia1ojIfRsH+zDIaMjeoMAediUMzOYqGUVnyDl9n2542oRQf+3V3qXwmkbpnieyn
	 Htq59QFNqsJ9InyhMuw/b//CtrvgtLDtQN2pK6Jfs+xs7FL80xOm8p955o+cX6MkYA
	 5RSGxojd+hasH0Ry0FxVL44Xtw89yQNGKGEjUKy02DmhdiZdfYd8sXCE/+SCdbaVc6
	 lNqgZm9vVUUaGkrd6GmxNaMaATs+JP4Ma7oudMnSN/fkbyXfL9/0DJKt6rW5eIeUML
	 yn0oqh7q238yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 594894081C;
	Tue,  3 Nov 2026 13:05:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C27A5435
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A848280BCD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Pe2DBKMGQlR for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AE5198081F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699935;
 b=RzxhyBOHvErq74K6QLqOqsLMTSzHzYIypwSLOcQihTw9hc5VVL6ppKmXaxRTvVZuQnnN
 /zzs9VTTvSh3icNON8gCd5ohwklZ9KlU2Tv2IZw/t+sKYNkDIezGsjfR73ZBeW7Gfcv+Q
 Hd8o7GmqU5OwvgyccMzhKIdG0BbOkLJFeCUPR8CDd0jsk53pbk+znGUREfnk+RJ/K3O8e
 XWK7krcXKU0GhAm59/TgE0NeCYc6ALsPgQPE5d9rqmFq627+8I/T8993vZjUTsGFFex5W
 sxXERrayR6B2OMBZ/TTMfWxmFJmrSnKRPm56WsBsNgjPFfOZLeAVG6Sy6Qujtoyfr2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699935;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=opxJgXCrn695wi7g+aO45tYt2qP/f5avVsRx9DorV78=;
 b=gNVIBMA976P2AVtGEB9dBQDoA8qAqOCBLP2H+GkuNHWBoYvL9yvnlRTSc8ds9OF2m1hJ
 8FxI1Hq/1gMiGjIpCi561i8SmlYVt3lRHvPmSJnsBOut39GnuOx2xuzkGObNulFUWBEEL
 iIsh6xqzMHz3ABLP7BspdLPydU/BRJp+UFnzlgGh5vgdw57ZYcHG9nooNS3l6Jq70kE7Z
 54uh9yYFPkhp2bjL3vS4+mcuPa21ZO/ixmAP46+GujDy9PYKQd5Rc738QXsXSOlAKEQNV
 ctOM7/uxQLZ1EObBx+eN333UEEFnhZQxOoYEBkeBhDKZqHEJQZQUEXwWxDKcuJWz3EQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bBKSoWC3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bBKSoWC3
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE5198081F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:54 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso31348545e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699932; x=1794304732;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=opxJgXCrn695wi7g+aO45tYt2qP/f5avVsRx9DorV78=;
 b=bBKSoWC3NhgFURMhRlVsMwsMGcRldis4XydV24K6FCXiB6SW8loRR9xFA6TbrYGCM4
 vVZPwsPMPbZ4vOUMav4/Op0z957+ZWvZWZZT/Aj7sztBwlLv4BSdN6D15pl0d1ofRx7O
 jdaa0XVj0fd4FVdGPG7EJcMek1+uDEXaRA41W6gu/0+dOC8GqefFhWolLVAhC9Nu+UDX
 vzOv6BEw1QCpPP8DeWpdSieSeES5iUfkG9huh8ri/hDrhuNpxB/09zh1kinnSORcqwMT
 nyXVrNTpx6T5XHgwMfCyBovyz+WV+gPIRUkdJpQAXFn+vxWdNcQB99x6ypRnvjxjj9ZC
 wPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699932; x=1794304732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=opxJgXCrn695wi7g+aO45tYt2qP/f5avVsRx9DorV78=;
 b=ShfmtkFibLHiSN79xcEkPEyfORtKcrbSOHBaoMGKwd9iO2+Nb9Jb+6O/ZNlaYf8FAo
 iMYfsUsDIoKZ9eEV8be/t2lr6KHQVQAMvNkbyLqoD+tcd9HZ9ZwTdaXxEVdu0bTMJAeW
 qvYNFscpUK+k9dUzi6yI8ACNk5JHZCvYgoVWxKQWNk5NIqtkoCKthYxY49hOYfQ74TDQ
 CwEW8fLyTxFduhsiXjBz+WxE9vOePJqofDUaHhIq2GrWlGuQE2MuosklGOJzTwCx/ZIO
 /TlPgy+5Sq4ttHiL4l9xrs2RX48cU8tCxNP8HQ+tdwAi+YZtkO4ZJADUDht2jMu17wY3
 PFeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2ZJXdsBgnC2r3fmKmGeT9vTqP6EsTZjuvByxIbkBLCvmZJZYmiETVxXPZ1rqmGG0klDkVVk8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/3Udq7ngwLgvV0C78WVcBNPaAyJoCZehlOHQUYVokkd4/Iocrb
 V152j0K/u89yx0mz25iZfDQ38UOz2Ggz07irbYkvAkJBkAmKU1L/jNC8xib8mDI3tCs=
X-Gm-Gg: AYBFou22tf7jg3DGTH4O4G62S1jxn7ni82bytG8y/O61AQbMSPMOplckUwO2SmhuAR5
 uGzjJbgEoeWUjnxuWwkQag5KmwNGtxiDd/HWilS+Ta5ZwI6Lc0zPQwo6kpPlzCCrIvt7TLhIX51
 H+Fn/tf4tuscySTfLJ70Vo0I2kp05ATCUNgBCL6vxo7ya9Sh2SGxhfRo2Milr+tY49v5XJocssL
 J6Hjx1ksk51FdQ/2pRFOYRNDab1e4tPWEiVPtI3WDoak8XhvhdQ45CBSPBBH8X1iUxAe5NDxA3E
 zlmQbKldPlGI2++ZM/B7iiwsZE4f5RaYuY1GLpgJNmxlh05XPi21LE6TF9ZCGqk531Mp9NBZvuR
 mvJ77GcJHiZPBkIEkrzm8lUz5Pvw6UaUkPSVcloQRkEbVuyLX9bHomjgpLvZ6b5UMWtNHO5GynE
 gomsR0GKgkJGfpdtztbpvlb9FqhBlS+EGvVJ3mC/UATBxuCL+hOJ9sEPYtfStiMkhIghf0Da2Xx
 69PBz+d+7g0pCUL/7nuPEqLpzIf1ck7rueVOLJUJInlRNRoC4SuzuPatG+nLC8hba4gc33XXLMx
 /sKSxoST0rS2EkYR5EHGl3G74Q==
X-Received: by 2002:a05:600c:1f8d:b0:4a2:c9b:9b98 with SMTP id
 5b1f17b1804b1-4ac177539f6mr277103795e9.17.1793699932281; 
 Tue, 03 Nov 2026 01:58:52 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e77409821sm19962999f8f.0.2026.11.03.01.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:51 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:02 +0100
Subject: [PATCH v10 16/24] arm: mach-k3: am62xx-lpm-common: Helper for LPM
 meta data address from DT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-16-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Me5wev7Xwuw2lEGJkp6Czs5VOEqh3YmdoP8RmZOlHio=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXG0TXa12VPa+ecZibbaNHp72WZPVC1ZqAn7unH7PZq
 pplcMC5o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACbyMZbhf/EO5aVLf4nyzG0S
 Mz6z7/3+jS8efbzOOzNWq2+e+wXnm28YGbqe7F44KeE+j1rWmfBc/0VrnR2Lls/1dD5zUPbKhis
 nWHkB
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
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

Add a small helper that reads the LPM meta data address from the
devicetree. The wkup R5F node references its firmware memory regions
through memory-region/memory-region-names; the region named
"lpm-metadata" is the one holding the LPM meta data.

This replaces deriving the address from a hardcoded offset into the
former single wkup R5F memory region.

The helper returns a negative errno if the memory-region-names property
is absent, if no region is named "lpm-metadata", if the phandle cannot be
parsed at the resulting index or if the region node has no reg property.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62xx-lpm-common.c | 49 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c b/arch/arm/mach-k3/am62xx-lpm-common.c
index 009d05db4357..a39592ce57b7 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.c
+++ b/arch/arm/mach-k3/am62xx-lpm-common.c
@@ -9,6 +9,8 @@
 #include <config.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
+#include <dm/of_access.h>
+#include <dm/ofnode.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <linux/stddef.h>
 #include <vsprintf.h>
@@ -127,6 +129,49 @@ int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
 }
 
 #if IS_ENABLED(CONFIG_K3_IODDR)
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
+{
+	struct ofnode_phandle_args memregion_phandle;
+	ofnode memregion;
+	ofnode wkup_bus;
+	int index;
+	int ret;
+
+	wkup_bus = ofnode_path("/bus@f0000/bus@b00000");
+	if (!ofnode_valid(wkup_bus)) {
+		printf("Failed to find wkup bus\n");
+		return -EINVAL;
+	}
+
+	memregion = ofnode_by_compatible(wkup_bus, "ti,am62-r5f");
+	if (!ofnode_valid(memregion)) {
+		printf("Failed to find r5f devicetree node ti,am62-r5f\n");
+		return -EINVAL;
+	}
+
+	index = ofnode_stringlist_search(memregion, "memory-region-names",
+					 "lpm-metadata");
+	if (index < 0) {
+		printf("Failed to find lpm-metadata memory region name\n");
+		return index;
+	}
+
+	ret = ofnode_parse_phandle_with_args(memregion, "memory-region", NULL,
+					     0, index, &memregion_phandle);
+	if (ret) {
+		printf("Failed to parse phandle for lpm-metadata memory region\n");
+		return ret;
+	}
+
+	ret = ofnode_read_u64_index(memregion_phandle.node, "reg", 0, meta_data_addr);
+	if (ret) {
+		printf("Failed to read lpm-metadata memory region\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Restore TIFS context for LPM resume.
  * @ctx_addr: DDR address pointing to the location containing the actual
@@ -183,6 +228,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
 	image_entry();
 }
 #else
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
+{
+	return -EINVAL;
+}
 
 void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
 {
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
index d5793759da4a..741e3ccbcbd0 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.h
+++ b/arch/arm/mach-k3/am62xx-lpm-common.h
@@ -13,6 +13,7 @@
 
 bool wkup_ctrl_is_lpm_exit(void);
 int wkup_ctrl_remove_can_io_isolation_if_set(void);
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
 void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #endif  /* _AM62XX_LPM_COMMON_H_ */

-- 
2.55.0

