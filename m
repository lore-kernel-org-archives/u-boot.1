Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31420606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U8avV/E4;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AWHFaFPp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D4418111D;
	Tue,  3 Nov 2026 13:05:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vtgVKJ-nrKe1; Tue,  3 Nov 2026 13:05:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E9A8B81155
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711120;
	b=n63kxf31Vtsf4bXokVvyVrvXcYjpMidmVAGaIEBlf25BWqIS0c4+xEmbO2seBSxiKuF9
	 /dZ6k1gKxsGuEiUeXPUeJN77ezRvXv4xNPEBd7+kBPh/MWvb5q8LynINYkVeiJ5GHnKIl
	 /P+0R/5C5j1I7CEKEfeL1tOT5/u8BlJm5f4TekeDfp+m+T8OfN6rACYkbsPBOeD6QDOMY
	 RT7Bbs3Bb9i4cYGsm8nHT63AnEjV+Qj5WfbN9W+bciB78wQJ8Ujw9O78d1re4i22dvtDT
	 5I3aciHQxYX1BG+knhuBl4emZLMATr3h1ePCwo8ZXIiuGmDibVpH/fRFAAL5Pr/mfOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711120;
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
	bh=2MReZeICvfrNfEg3LrQBm0Vlpb2yCuGCOHJL7B1AFaQ=;
	b=P82ULeHYBtH8a5VVXmPYa3sPn5P79awZANbE2OkHse+alS+m5sKTkgCtCIxYiTimEGbs
	 jLLtgEz/7k8U7rDBxgWW1tggWJDMSVaT1t8jvb7pNqr9/mXcg1J2e1c8gvU3fcV38eWbu
	 MJ3xXcLkoT1aufoiVgxsWqJxiDrWmcSFn88fd1uqnH0kYgCVocVe7zs5Z+c0vy/X6RJCT
	 DtqKo+GFsvyP67wI58obDTFsJjXeq8NWIulzYAfXgHzh42MtDdZx1h+gmU6rrD+CBaFcz
	 WCDUQ1xFKLNNVL/7UrDmUmPtHRF7+24aPmeGIJY3l1Zdt7OgVn5Jk5ZNNtft1MrCzYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711120;
	bh=2MReZeICvfrNfEg3LrQBm0Vlpb2yCuGCOHJL7B1AFaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U8avV/E4Q4gNPF/sCA0vT8GvdEulQe9dhEztcpV/UD7VzNzunouv8O1FjgealEiYY
	 li+YEDpHPGt27Wv79FxvvXLZiLRXROQJKACd/vNY6cVXElQrbkNk0BeDUJx1k/PZSn
	 GDTcmOn9pEY9WKEIskJTu7DOe/H9GoV3atkCxJRfjHbAUL2rXDcegZ0gsZlsCQWFWD
	 eI1SBHJuuKPBYzLfz+UXxUNc8m3EmBbNSafy9ywv4oJK7Y/MC+EFGtUng7cS+5t7qL
	 RZLctY0+jaIlny5TnpLEw7JTvvJT/QnUgBdXxV5zXVdjeYBq1N5Bu22T58CmPsF164
	 /GK4RWAge5fZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9A8B81155;
	Tue,  3 Nov 2026 13:05:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A0F58356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93376606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LULwJ4NHOfSw for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6244B60670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699926;
 b=TbFsLB3gNoff3h0NzNw4PCD+QafhDgWW8TdVxk/rR7LOBb6fIr9Na0tSqHAGk/EfIECV
 wScZFJUixLJPB61GiCGLGB8cXtG3r6vaTcZG4WRYJSpvIDuP/v+5B1eu6IZs/FfhVVmsM
 qDNj9Ag0hRqGvjYAqHtZmSvC93RZJMOXiTJHP5NSr9XjEAUI6AGbprAQ/kTafvS6xEXyZ
 HGLZFzJbxg+Or29UUWzb2gjIZDnWg67X40uvDNhnEcV3Jv4O2qqmQlP0YeNYb0EEn377m
 BBxuXPiq6xqf7JOKrAmu2jq2A9cP8mnD/GAcE8f3SE2Rvkd2FkVDrW0s6DAU8zvX+tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699926;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=2MReZeICvfrNfEg3LrQBm0Vlpb2yCuGCOHJL7B1AFaQ=;
 b=rEOjFBj+5MSb1oxJ+dkyPLIWKmwfJ2iDIoWf9flCHpSFcFyDmnybtxDbWMsA6a9gEWVb
 RsLFPHFFayBufOmWvd+/nyT7qzLWvp3rR5BylNUXHsLzjpn20lnDIQXcTq3pZH0sdTjAw
 icZe9ODf/9+owpgJUdwCUApNzlF17iXQHlNdo0le7oyWo48wrna5Pq6MLOyS634qbPzGj
 W/Qno/gbsFcWNYA16MVdqtjEFVw2AGuFAN5ipcKQSfTy/vFAZLBpOjrtBXyAfiOFNxC4t
 coti6irl0kPRST18SGUG/bLiMSO7886WMiNEoB7Yaq4GDpTKvyHeP1ATw0QJEDTAVxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AWHFaFPp; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AWHFaFPp
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6244B60670
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:45 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso270796f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699924; x=1794304724;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2MReZeICvfrNfEg3LrQBm0Vlpb2yCuGCOHJL7B1AFaQ=;
 b=AWHFaFPp7TWgq1kRvsPhOUnlDIBIC1ue8LvN9a1MujYA/tAEjlDZyqgVSKLzKzmOIk
 dF0Tjl+Vc6YsfMxgXKiLZdUBftBm5pfA4hT+JY07S4NqWysmvShQ19VjfkXPUtkbbEtR
 hiuaRAkkd7FOWby6U3EFMYq7KGvZUc3KAFfDSWseczJhIDVhyXtG+yzpX4RPyoTqSu/d
 3v/jWuQ8CkK6dw6JmDWcDG4yBRVQUJmT8+/jpjRGB4Xk7D/0QLm7VTjmtu3vE+EibGml
 gU8nqfoDFQNtj5uW/mjQanFZUQpQqTgiPCeRkRl4MYZyaDxErsY4AtSKwymm3aCYViKe
 8SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699924; x=1794304724;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2MReZeICvfrNfEg3LrQBm0Vlpb2yCuGCOHJL7B1AFaQ=;
 b=b4RucLE3qUkTg/0lo9hG62GjR1LYvw+BVhRTkoGLyh3KtumOMDPyF5ou4RFyCHRroS
 Da04HodH+q11m9L3LbAWdrqNLokuVsZo8YpR17Mgnzj8GL+16o4sD5FuIYqJ8f1Y0vP7
 ImoBNyeAyQRTFMEOoGcmJW+ObQpD9EJEVzGzIBtgnY86eZ4Uy6okcqWIKz8MyCkkJDVe
 IYYh6R3dezbfUFcq+7LotV1sbF1xNZEiMfurAw/o2WyC5YhlyV3JoC61udoTB4fQOd1R
 va3xGkuuXeouvdlqxFSDwVBjBOW6+GBCVW+8iHBcd77cUoteib0iNbn/QwjKKAsitNlA
 zVww==
X-Forwarded-Encrypted: i=1;
 AKwUvByzvAcgdQSm9mDEF1R1MwZ1W026/5bI4p5dEZUd+iSNGQ+qUQ/3PFLACUYNmTfT2g9ur4NAG5w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/O+9WWk9t12wY+kdh+gnNWPxGBQHJRgVZ1fccqnAAMGPWfuFig
 0I5LVcEICZbJlmpyAb4nD5SkvGCfBCQhZSMzOXb79p2zVJ/VLrj//qjsNVIqfsa6zss=
X-Gm-Gg: AYBFou0H+9DE5M+qe+0h4gWrGXOG/xQvUUvz1k6atWPCCsG0uDUZkEnC4oaSDXc4o0a
 1RVWGV6WMRBkB96AtmeKfbILWw8SvLlVsSAVGm3hBjWm3+ktIVa0EYNSwFSI9KQbzQrBjYysmIc
 lnwAvMBG/Viz2kzY685yefdJ5TGA2z37veH7JPep5zx8syfntX7j/4pAMIxCjWOS3NtmvVs/rSG
 h42MyPnh8+ApTJ98JGe2M2iXlsZsVkgmAIsnZ4DRrdE2638rXgOz00gxY+9uJxciBVmYdjNSJDk
 udWJ6jWIrdsQ6IMw+Ea0cx70y56fZ8u4DssjKS0L5wBtAHBydlQ/vKDwhDOyxpb0xkJrpXWx9XO
 ud3h7b+2pwS+Kmy3v9FsbuHBYavWhoeK/ZvgVLKlkRdYtgvXbdn5Py/tiivDWdLyKJHf8QVqPTE
 98R8bIwTMM4P2LgxWIN5MGyefgbPAz0eHEQD8qpVs3YykTwdrpbmfQjFN89ZJI1CoJis2/2Et9p
 3AUYRCTiml9FLBb8F0pFa6hDaor5ZLS3f651XkgVe+apoUZ53QwyhVR30jGp2iBcXmnzlvw5ZUf
 g2gvqOcBnP6Egsq0Rjm9qk7Y4Q==
X-Received: by 2002:a05:6000:25fb:b0:48d:fbe0:62e1 with SMTP id
 ffacd0b85a97d-48e64d028afmr36948371f8f.27.1793699923949; 
 Tue, 03 Nov 2026 01:58:43 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723bfsm22711850f8f.15.2026.11.03.01.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:43 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:57 +0100
Subject: [PATCH v10 11/24] arm: mach-k3: am62xx-lpm-common: Add CANUART
 wakeup check helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-11-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3110; i=msp@baylibre.com;
 h=from:subject:message-id; bh=nyHc9+iAdjI0vKmVLunXTlp4603qsw+VVZInO/Jc+2w=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX6/9wWx/3USstVmO5/GbCe5W0hVKTCk15xXx1NrV+/
 Z9YdqOxo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACYy4SXDPztnvsDJSZF9Hwx3
 bjRcP1l57c/4/9UZnNNurmqc/O5g3hGGv8Ilwc+2yJ+xPa/ceO7CPv85xYJhiQGvwo8+loiMu2c
 SywkA
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

Add dedicated helper functions to check CANUART wake registers and magic
word. This helps determining if we are in a wakeup or if CAN IO
isolation has to be removed.

Also add a helper to detect a low power mode exit/resume.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-k3/Makefile            |  3 +++
 arch/arm/mach-k3/am62xx-lpm-common.c | 38 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/am62xx-lpm-common.h | 16 +++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index b2fd5810b67c..7a020a8318ba 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -7,6 +7,9 @@ obj-$(CONFIG_ARM64) += arm64/
 obj-$(CONFIG_CPU_V7R) += r5/
 obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
 obj-y += common.o security.o k3-ddr.o
+obj-$(CONFIG_SOC_K3_AM625) += am62xx-lpm-common.o
+obj-$(CONFIG_SOC_K3_AM62A7) += am62xx-lpm-common.o
+obj-$(CONFIG_SOC_K3_AM62P5) += am62xx-lpm-common.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c b/arch/arm/mach-k3/am62xx-lpm-common.c
new file mode 100644
index 000000000000..424d7457c596
--- /dev/null
+++ b/arch/arm/mach-k3/am62xx-lpm-common.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am62xx common LPM functions
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#include <config.h>
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+
+#include "am62xx-lpm-common.h"
+
+#define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
+#define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
+
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
+static bool wkup_ctrl_canuart_wakeup_active(void)
+{
+	return !!(readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
+		WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
+}
+
+static bool wkup_ctrl_canuart_magic_word_set(void)
+{
+	return readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT) ==
+		WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
+}
+
+bool wkup_ctrl_is_lpm_exit(void)
+{
+	return IS_ENABLED(CONFIG_K3_IODDR) &&
+		wkup_ctrl_canuart_wakeup_active() &&
+		wkup_ctrl_canuart_magic_word_set();
+}
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
new file mode 100644
index 000000000000..36dcd20a9b80
--- /dev/null
+++ b/arch/arm/mach-k3/am62xx-lpm-common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * am62xx common LPM functions
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#ifndef _AM62XX_LPM_COMMON_H_
+#define _AM62XX_LPM_COMMON_H_
+
+#include <asm/io.h>
+
+bool wkup_ctrl_is_lpm_exit(void);
+
+#endif  /* _AM62XX_LPM_COMMON_H_ */

-- 
2.55.0

