Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7A606A327
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1CBB+Yke;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EYIQgFzl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9742407C8;
	Tue,  3 Nov 2026 13:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XzxByfsAJNln; Tue,  3 Nov 2026 13:05:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E5FF407D4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711123;
	b=JxTw4Vrgjoj1pOVEU2Q1D7mR3LOU1gWPdqyfvru3vHTxE9nQKkbXK48iUzsZ0PcZ95FM
	 X2XfdfzZzB4zVlb2Dhs+ocaWhNZaPVYmo0BRKajZUewtMTjCg4kEbBB2gWSZS8sGt5aU2
	 BR0Kul3Pfx4extsO00sCiKZEbFCseTmOLdSDHxPixjbWRsNOw9Vq4xospTZ8wF/e4AM0a
	 95edtMzhO+BMrtUYL1BRhbsTqWMcJfW/7vRZhsjjlynW6dsqxKjyEzZY2uu9uI4Ac+hRn
	 hiHaFz8bQYoJ1/5BSkiXck+R0W/y3gQ93OBjgLZ6hohka4Xy6UkArUdXzx4BXD2SBNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711123;
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
	bh=zmCwbk41RZWOUEb8F5eYSFFzqPt1mCjqVVclIKGzWnc=;
	b=TTFIxiitrxK+++oo/7L8SFd/uhAua79zHbUj11M9/PdjxtvyNcsVeBg98Lo+mB/Pw8Pr
	 Fy82HC6YkURIqEoAJ3DdUgfBITvEP2V9kuuQWAqrBe+v2iyWC2BHi3rkkDSEwjPzOqYST
	 t68yAIh/M+BuIGZKpGOaD+H6IiEewham/lvWEZsotDe7Srl1F3gz3/4TXYReVTwvpB+Qh
	 0BDAJXdgCuXYFg+j6XYKrNXA6r30REqkVvfw2hT0qmWxshkjRBbMXyvDLjoCBzp/Y+fD1
	 fz61FFPnCTu/GaMKyOvITM7OggkHLm1U+pcVCNa2P8wH5EjcTrY7pwOSxxEn3FpJ6OA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711123;
	bh=zmCwbk41RZWOUEb8F5eYSFFzqPt1mCjqVVclIKGzWnc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1CBB+YkeNFdksKvut69LPLpzv7N/RLml0PO4+k0u9oImx2oR64C/zUAkSMycaFipO
	 3CJYQ7o0MrtEyhSairvXoJsXcvUPuCbaJy1YbVFMWUc2xLgFHSnKNAfOGvIf6qOgKk
	 F4tMWagYkXnD+KsqGnJ8dyRiLy7Nuip8B+JQawos09kuWl0IIgT0tHT/r0w4l9tuwo
	 VYLRGb3e5OxJvnEUDy8r1SOX07By9WHRVsLjfSB5WTlD5Xe6RNroithggC1Hy9AbYa
	 PfFkFhMZXafxlfLXyb/2baJHk3JLaHBOKj/Srlko6U6jwp0t9YXoJCzjatEP1UzHNG
	 1EVDSp5tbx9Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E5FF407D4;
	Tue,  3 Nov 2026 13:05:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CB931D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDBD640080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZcaw22WONft for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3E4D14005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699930;
 b=YtbRU19s0dZ6YC5Wpvbbkn5YPqcEyt1zWgsqJ3pT2lHePPOC4jO2UPNcYq7lVq5BgqT0
 uOIMPa8IYgJ89y65kpDfTqo8bAQ4zbssjZBRDETGkQmt1qlQnA5DbV7iskj1XDQ51melv
 7qtMpzwuj/yGtFaMZh76CcMXGZz9llcZ4XAuYWjQtMjAP2qkBW2dc+C/lAAcpSM9E5Ky5
 l8mNUEqF+1UJBN+kxTGUW/8Hc8drmi+EJfQiq2boem8RG6sbfcK8QudDfgv1llXyrRV7K
 R5yuzrQ378ZmdeTssmaHv3xLmosb+njAzpsgcWe/SWZCtpLyOjfn8VdBqjG1D0aoOQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699930;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=zmCwbk41RZWOUEb8F5eYSFFzqPt1mCjqVVclIKGzWnc=;
 b=Y9svHC7oN8/D34yet2YvsLRopuQvpwCNp4Dk7/63LQ3aMDi8wzChHVt/f/8EbwO3t7tt
 2KlyluYOiGq6pwYv7Wd3idgC4qbiKjT0MfKq2nsExeYZZyMFLqFfQWSMI956pwmE57q69
 KsStB0veAGanfa/qpJDNcFwLCJUA0TQDgYH/aMfiFy5di4cmTMUYGKrubxYg5P9fySmVH
 11Yv6aa2imQKCkPdqDQLMSROceW8Kez0OGIhggJWu+CBpTJAury5hE1ySyZMC07sV1/eP
 RugHwizk25KvuxgdOKmr6CUNMTTXLbrtPeyQ2fe32hh2N2hk3tUQMX2f6A0js3It13A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=EYIQgFzl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EYIQgFzl
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E4D14005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:49 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso31347835e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699927; x=1794304727;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zmCwbk41RZWOUEb8F5eYSFFzqPt1mCjqVVclIKGzWnc=;
 b=EYIQgFzlQ+6nckA8VdVo2/28dDRgUhr6xcYj/froo7x8XoG5MfPNjMWi9bxDc3Fqst
 ROiVeYn3dndOdz96B33EaXUB1dpHFKNsT/lRMkUMKOpBPWlwdjR7qFZuqesVseQ3TG1H
 vWNYrJul/fJ/L5PTe3UBb7wu5emHzQmkkv7/5vhPf+WcbS/a0jqfAn0tHMZ6wjPvoAuv
 LcTc69ilv8AGve0u6CCbsohE09TCfeBA6Atz4rXq3u2oA4BzUe4ev6s3lJbOnjM8atB/
 lIZocA0c7izyHzy4pJYXBYcgkXUm/w7jVZGVDSMtPUjAbQOkpfKaA4xyQde3J16QUq9F
 wXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699927; x=1794304727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zmCwbk41RZWOUEb8F5eYSFFzqPt1mCjqVVclIKGzWnc=;
 b=kDJ6/D92oqMTlxWcF1FYDapM0Cm3GRGKWtNWsp2Ejfvqh6CIbzzLgHwJNqc+5ST/j5
 tSIPGhVXL1vT4vJiagIwbV87k7i9P2DfW0pdvJREO+I3Ekn1q2iS39N8Vljs0gE8u0BI
 63OctQVqHqdzD4pY7enQvUSgxvpwWZJiKBmN5IX9CRdZEhjcKtxVYAx/ttUXRIGtbEQG
 3sA+dSIPi9G3shzRNs7HWKuFBVsJyvGdUrPSG4hGW2ieBZ3pjO8/XRJUifWMgnM5fFCe
 J46CrGQ5K/EOHyomM2ScnvZoiKt7yaUkqDaohlg3j4HK5FwoG/TNz4gHtnWLyCpOCMRn
 G3YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCuTtvLRVeMEbKPcKJrr4Hm2mdKKmfvZPUy+WgfQtKvFgEQYQ6A4PbxHpq60FOJ53U6M8eg2Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/aOOZWsErneCs3BY145BnI+tWGT0SNSGz5QlcxoFow/0kyAinp
 T3YGn/jT9ItlEtjiI7xojhnWjn0MpNf9Lau7i/wdwyIlyqoJ1RUEHUHxHASFhVIDBx0=
X-Gm-Gg: AYBFou2dFbGyaAjUAQEBj+iIZW73/YhthWSYlSi+k90ROn+qiyem2wcVLEGgjnV4/dA
 Z+AbsFejloCeVsj3SbS1bEUzqYvFOBu5J0XWcYTCMzGnbExXpgNevBAUl59EA0PjlnvhsdRsXcF
 VnVi8lhm/gziNfBYdkkLf1CLx4Z2e9rXo/m8yclYSmYzPwAMPkh7+fBkB2hA05WM7VuUBJwBEHe
 63hp/4dprDHcvSHyFDvw5lFjQU2JBaCbTRzsldGza9NwvZFMBsOPovKAoA1QV8aMfab4NxfN9i3
 VesezOQqZD+YdgwuCRiRGnrEylUr6IGGUZZlprEsZ9eHomzOPIo1jsA1OEsQKCQmsD6/EEkxMWz
 p26IefFkOmqAZT74o1aOf4okkLdaxA8WeXuO75sJOr9W4q83wDRcvvJ0uECQ6q2G3YZ5taA8OV5
 CRpQJrIrPlA0EwJUqQ2ZSiwgcY9qmbBf1eQklPBSnbK9yi8TXjCweA717nQIm2OADpeh3zN3wOA
 EddI3RHhRNqCRZ4ubITtqkty+faUXRBOnab46ybzdor0j4GowtBNcshPVZVkAsuj5hanYWmTnl/
 GMOArCt1RiRzLaLv9Ft8hOSZTw==
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id
 5b1f17b1804b1-4ac1719112emr276267175e9.9.1793699927624; 
 Tue, 03 Nov 2026 01:58:47 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab3ea6a9sm69739665e9.15.2026.11.03.01.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:46 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:59 +0100
Subject: [PATCH v10 13/24] ram: k3-ddrss: Add support for DDR in self-refresh
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-13-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11558; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Jipx0kdWIPdchsn9f19xUTLcuAsoledCpgUKzdUr5iA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXG1jLW+f8jVxQc5SZr8hhKbf4x4ptgrmO7BmpfrNby
 i4eP3ygo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZiaMnIMEHu4CcRa9NpDe9j
 NlxyiZ/HqvUsZ33WH0fOmtd9jr2GZowMi5acLXuzwm9uIH9V9mxD5bdLJzz6H5f9y8t0eewNp+/
 NTAA=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In IO+DDR the DDR is kept in self-refresh while the SoC cores are
powered off completely. During boot the normal initialization routine of
DDR is slightly different to exit self-refresh and keep the DDR contents.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/ram/k3-ddrss/Makefile       |   1 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c | 181 ++++++++++++++++++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h |  20 ++++
 drivers/ram/k3-ddrss/k3-ddrss.c     |  26 +++++-
 4 files changed, 227 insertions(+), 1 deletion(-)

diff --git a/drivers/ram/k3-ddrss/Makefile b/drivers/ram/k3-ddrss/Makefile
index bb7dc05e3d99..a125675a2931 100644
--- a/drivers/ram/k3-ddrss/Makefile
+++ b/drivers/ram/k3-ddrss/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_K3_DDRSS) += k3-ddrss.o
+obj-$(CONFIG_K3_DDRSS) += k3-ddrss-lpm.o
 obj-$(CONFIG_K3_DDRSS) += lpddr4_obj_if.o
 obj-$(CONFIG_K3_DDRSS) += lpddr4.o
 ccflags-$(CONFIG_K3_DDRSS) += -I$(srctree)/drivers/ram/k3-ddrss/
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
new file mode 100644
index 000000000000..20181d0a876d
--- /dev/null
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * K3 DDRSS LPM specific functions
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#include <asm/io.h>
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+#include <time.h>
+#include <vsprintf.h>
+#include <wait_bit.h>
+
+#include "k3-ddrss-lpm.h"
+
+#define AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL				0x430080d0
+#define AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD		BIT(31)
+#define AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK	GENMASK(3, 0)
+
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1				0x4301830c
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE		BIT(0)
+
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT			0x43018318
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
+#define K3_DDRSS_CFG_DENALI_CTL_20				0x0050
+#define K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE		BIT(24)
+#define K3_DDRSS_CFG_DENALI_CTL_21				0x0054
+#define K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE		BIT(8)
+#define K3_DDRSS_CFG_DENALI_CTL_106				0x01a8
+#define K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT		BIT(16)
+#define K3_DDRSS_CFG_DENALI_CTL_160				0x0280
+#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK			GENMASK(14, 8)
+#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY		BIT(9)
+#define K3_DDRSS_CFG_DENALI_CTL_169				0x02a4
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK	GENMASK(27, 24)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK	GENMASK(19, 16)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK		GENMASK(14, 8)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT		8
+#define K3_DDRSS_CFG_DENALI_CTL_345				0x0564
+#define K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT	16
+#define K3_DDRSS_CFG_DENALI_CTL_353				0x0584
+#define K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT	16
+#define K3_DDRSS_CFG_DENALI_PI_6				0x2018
+#define K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R	BIT(8)
+#define K3_DDRSS_CFG_DENALI_PI_146				0x2248
+#define K3_DDRSS_CFG_DENALI_PI_150				0x2258
+#define K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN		BIT(8)
+#define K3_DDRSS_CFG_DENALI_PHY_1820				0x5C70
+#define K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT	16
+
+#define AM62XX_WKUP_CTRL_DDRSS_RETENTION_TIMEOUT_MS	5000
+#define K3_DDRSS_LPM_TIMEOUT_MS				5000
+
+static void k3_ddrss_reg_update_bits(void __iomem *addr, u32 offset, u32 mask, u32 set)
+{
+	u32 val = readl(addr + offset);
+
+	val &= ~mask;
+	val |= set;
+	writel(val, addr + offset);
+}
+
+void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg)
+{
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_169,
+				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK |
+				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK,
+				 0x0);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PHY_1820,
+				 0,
+				 BIT(2) << K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_106,
+				 0,
+				 K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT);
+	writel(0, ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_PI_146);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PI_150,
+				 K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN,
+				 0x0);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PI_6,
+				 0,
+				 K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_21,
+				 K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE,
+				 0);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_20,
+				 0,
+				 K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE);
+}
+
+void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg)
+{
+	int ret;
+	unsigned long timeout_start;
+
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_160,
+				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK,
+				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY);
+	ret = wait_for_bit_32(ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_345,
+			      (1 << K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT),
+			      true, 5000, false);
+	if (ret)
+		panic("Failed waiting for low power command %d\n", ret);
+
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_353,
+				 0,
+				 1 << K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT);
+
+	timeout_start = get_timer(0);
+	while (1) {
+		if (get_timer(timeout_start) > K3_DDRSS_LPM_TIMEOUT_MS)
+			panic("Failed waiting for low power state\n");
+
+		if ((readl(ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_169) &
+		     K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK) ==
+		    0x40 << K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT)
+			break;
+	}
+}
+
+void am62xx_ddrss_deassert_retention(void)
+{
+	int ret;
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
+				 0);
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
+
+	ret = wait_for_bit_32((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+			      AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+			      true, AM62XX_WKUP_CTRL_DDRSS_RETENTION_TIMEOUT_MS, false);
+	if (ret)
+		panic("Failed waiting for latching of retention %d\n", ret);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 0);
+}
+
+static bool am62xx_wkup_conf_canuart_wakeup_active(void)
+{
+	u32 active;
+
+	active = readl((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1);
+
+	return !!(active & AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
+}
+
+static bool am62xx_wkup_conf_canuart_magic_word_set(void)
+{
+	u32 magic_word;
+
+	magic_word = readl((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT);
+
+	return magic_word == AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
+}
+
+bool am62xx_wkup_conf_boot_is_resume(void)
+{
+	return IS_ENABLED(CONFIG_K3_IODDR) &&
+		am62xx_wkup_conf_canuart_wakeup_active() &&
+		am62xx_wkup_conf_canuart_magic_word_set();
+}
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
new file mode 100644
index 000000000000..742d224327e4
--- /dev/null
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * K3 DDRSS LPM specific functions
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#ifndef _K3_DDRSS_LPM_H_
+#define _K3_DDRSS_LPM_H_
+
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg);
+void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg);
+void am62xx_ddrss_deassert_retention(void);
+bool am62xx_wkup_conf_boot_is_resume(void);
+
+#endif  /* _K3_DDRSS_LPM_H_ */
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index c406998b20aa..54e191df8de9 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -20,6 +20,7 @@
 #include <wait_bit.h>
 #include <power/regulator.h>
 
+#include "k3-ddrss-lpm.h"
 #include "lpddr4_obj_if.h"
 #include "lpddr4_if.h"
 #include "lpddr4_structs_if.h"
@@ -119,6 +120,8 @@ enum intrlv_size {
 
 struct k3_ddrss_data {
 	u32 flags;
+	bool (*is_lpm_resume)(void);
+	void (*ddrss_deassert_retention)(void);
 };
 
 enum ecc_enable {
@@ -866,6 +869,7 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 
 static int k3_ddrss_probe(struct udevice *dev)
 {
+	struct k3_ddrss_data *ddrss_data = (struct k3_ddrss_data *)dev_get_driver_data(dev);
 	u64 end, bank0, bank1, bank0_size;
 	int ret;
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
@@ -873,6 +877,7 @@ static int k3_ddrss_probe(struct udevice *dev)
 	__maybe_unused u32 inst;
 	__maybe_unused struct k3_ddrss_ecc_region *range = ddrss->ecc_ranges;
 	__maybe_unused struct k3_msmc *msmc_parent = NULL;
+	bool is_lpm_resume;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -880,6 +885,10 @@ static int k3_ddrss_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	is_lpm_resume = ddrss_data->is_lpm_resume && ddrss_data->is_lpm_resume();
+	if (is_lpm_resume)
+		dev_info(dev, "Detected IO+DDR resume\n");
+
 	ddrss->dev = dev;
 	ret = k3_ddrss_power_on(ddrss);
 	if (ret)
@@ -895,12 +904,21 @@ static int k3_ddrss_probe(struct udevice *dev)
 	k3_lpddr4_init(ddrss);
 	k3_lpddr4_hardware_reg_init(ddrss);
 
+	if (is_lpm_resume)
+		k3_ddrss_self_refresh_exit(ddrss->ddrss_ctl_cfg);
+
 	ret = k3_ddrss_init_freq(ddrss);
 	if (ret)
 		return ret;
 
+	if (is_lpm_resume && ddrss_data->ddrss_deassert_retention)
+		ddrss_data->ddrss_deassert_retention();
+
 	k3_lpddr4_start(ddrss);
 
+	if (is_lpm_resume)
+		k3_ddrss_lpm_resume(ddrss->ddrss_ctl_cfg);
+
 	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
 		if (!ddrss->ddrss_ss_cfg) {
 			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
@@ -1019,12 +1037,18 @@ static const struct k3_ddrss_data k3_data = {
 	.flags = SINGLE_DDR_SUBSYSTEM,
 };
 
+static const struct k3_ddrss_data am62xx_data = {
+	.flags = SINGLE_DDR_SUBSYSTEM,
+	.is_lpm_resume = am62xx_wkup_conf_boot_is_resume,
+	.ddrss_deassert_retention = am62xx_ddrss_deassert_retention,
+};
+
 static const struct k3_ddrss_data j721s2_data = {
 	.flags = MULTI_DDR_SUBSYSTEM,
 };
 
 static const struct udevice_id k3_ddrss_ids[] = {
-	{.compatible = "ti,am62a-ddrss", .data = (ulong)&k3_data, },
+	{.compatible = "ti,am62a-ddrss", .data = (ulong)&am62xx_data, },
 	{.compatible = "ti,am64-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721e-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721s2-ddrss", .data = (ulong)&j721s2_data, },

-- 
2.55.0

