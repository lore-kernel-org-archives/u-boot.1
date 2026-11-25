Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93794606A33E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yjCy+x09;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tz5EWjrp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21A0F608A3;
	Wed, 25 Nov 2026 13:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z9RZK0U9bcgs; Wed, 25 Nov 2026 13:18:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86C12608B2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795612696;
	b=HQh62UIAS9JpVU/KULQuLJ2IA0OTYoQx3LUAWYmcpDpJdi9JXMJqwTGgJa7gxV1crTVy
	 z3zHmgVIbGzz1ivg5XDLZl/R+EKKtAGolOL4p5M///0m/6YtPtszBpXPFBzonRCVW0sWE
	 WDiqCOk+JbRmHr+AmG9b8ePnZ54VF26rMhYLZ8EzpY7Rc43MASUBIMik8lKin9NlQ0QaJ
	 wmllt59vSu6pH0TRoABYIbVf0k3zJSsfV4AQ7AGhz+StjdvTMAbGZeM45hxi776B3Bk0j
	 D66eoE7OXNbrS7jeDX1QGdIN/ann6cs6Y4nXBODBpX5sYYB8W86Y2fsyd3X1lollaFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795612696;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EJ6/6P8JFrSsAQW9qIHu9MBfejhzjAhDoiowQosfmkE=;
	b=UY4qmxCWqmyqDwK3bPGaJoi5C+wokNTeYDstCjeMe+rEQIpQJbelkd535XGK70qbKsEr
	 5mir1A8CkF9Bj+WfOO3rrcTm4TIsIXhn/r1u/nQY48nv1Ke2rx4usOJ1iMqRGakwgPC3l
	 Ey/SE2tvkeAoxRwNDEzT5wxB1LlFkLWVqAI0oGMwgUASY5Tdt3EmRe39DIlTFW1OOuEDx
	 b42Yvd6tm/e1YReGNBH6u+SvfvCxNIhrMkEkbXRPNh1rc+Zb1elWmFRAL9zNjvynAlqki
	 h6a7vZMcxkMPJeCy9q4DgBJLWYYfuIf/koIfZkSyBO6ORV+8aGjepAtKNJ2MGgsiejw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795612696;
	bh=EJ6/6P8JFrSsAQW9qIHu9MBfejhzjAhDoiowQosfmkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yjCy+x09F+5Nl82OcCPI9N3ayogULSrZeXoOnrmzoDyP/cPxLqbp8Gp6h+VN7uKq1
	 mG/NRrhpQigMQj28GZlW+Pq64AaTDzX32kp3b/5F4P94ez6s/ajWaRRiuhqPStzKO6
	 dgxN4nCSrkhxdXNG3uA0KwbZ/Zsr5mQ7rwMWAtj6RxAypsjZI7fekViys1RoKvX+oy
	 aKB/R0be/5SNqU3rAATKumQePzYeOd7tKYYd42DCiMRyQTwoK7aopHsymKyTD3Dw36
	 ++Jd/mUA0B3hAQQKU6T3h8USD+9uIfPxQu+qqWPG7rbwo4UI9GCE0zYrzcdVhtTXl7
	 Eam6pAipPZtRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86C12608B2;
	Wed, 25 Nov 2026 13:18:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D2ED325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EC03401E7
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:14:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qd4Gs7jA5sqn for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:14:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 54F06400D6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=ssunkkan@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Tz5EWjrp
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54F06400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:13:59 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8a07078200fso2925291b3a.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605239; x=1796210039;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EJ6/6P8JFrSsAQW9qIHu9MBfejhzjAhDoiowQosfmkE=;
 b=Tz5EWjrpGBXjtQkLCZMOcik3luV5xqDHJ6RvZ5K1YLylEQGI2sczMKW24OgdlUP3ml
 INn9Cd1/DxsTPcx3c0pEAeMnLoi2mfR+jgmUH9ComBJIfLLphQOpYKH43e9bclMlUROE
 /hefY7PyPqfmfu1BG3E9Iv2VY1hSK876fogBYCysSt7Mj6Tr4qm5apRKVDB7nfezF6PF
 SLAH9GK2ewNOS3xCLn61jpOGsGH+23HSSoaHX7BJT3yRIO3LiUF72V+VNp2/Dh8Q3V1U
 spQJy6xh/wY3YHRpLE5ZKR5lvUAghayAQpFr9JjUoe1k2Qw19gKcZdR7UIuFvOb7eQQw
 Pt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605239; x=1796210039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EJ6/6P8JFrSsAQW9qIHu9MBfejhzjAhDoiowQosfmkE=;
 b=MkgwVljabOPx92r9VVkf90PUxmfgEjgyNYCkJ6wLWXU/VhwVuPdGuKNfOTJEqug22A
 4KmLCK8jRmE97WcLVf3Cq8hWo37yzoyZWNJEdJJaLLsISm6dXudhkaswqxnYQ3P7hFJu
 hwXIVEc1f8fwuwBdBViI8EOcOA7/cLT/A1+7f5av2CC8AF2wOsSlCyooIVWSDmfjbRD8
 QH8f4/Wjbieq/1z9wQ3kzE/LqUwOzggjuVfYxhwmAJ+89rLYqfaiB507uM0T6JvnhPVV
 J1pJZ5INurIupn9I4pN61S+yLuNof6jyiPVW+CNkR8MHgudwr/+BbuyklTUj2l5tpZYv
 wWGg==
X-Gm-Message-State: APuU4Z/YnpM8wSs3ox6XZdRdLixQV39QRd54t9USJp7dhp5S/45vrIIX
 VzEwgwAbJAFnCLxoMBzLVeqNFtTvQxkqEc1XWepCe9f3cSH19CuomIwSA4MTdluj
X-Gm-Gg: AZFdTZdI//SChXysxtgGeJpum1TawshV8DQw969KOZbj5XZ9n/yPbh2/o50lgV3NhFF
 oYrI5YOqydz17fY/fH+X686+guDk07rbHWN3mw0cfmjsfRbxJgwWaTK7rmmmKewSTwTlLPiwWh2
 BZ7axR5Wn7dXvMmYJ+D8FkGqWyjq+PATBWDkpd0ZwH9UOZxL1uS5n3j9lZzrlvWApmJ9RKKJKs3
 2IiYMlz/V04dix8BL61kSVM9ETdkXIjwddYbn7FnXe8/V1SAQjkul3e9zLXdq6Hnh78hDWUecCi
 4yHOQnjTTBOjOKosEedd5xrfLGGjlZAJadF65zDz6AOJ3HNuJNdVBJORKFo/3MTGD9NFkq8XlO0
 G27s7Ycsi/PD7iVn4/vEPFmsje/T1CwYQWBeHMc5yBCPrbZKZbdxnJOBwmBNnbZm5hiwunPG5It
 2Na8+v9QeY4SnykglSYh2AmW0Vok8TfW2lYeWu5tyQyDB2b4ey9IT4SCPdw+HZcLWr/+h2mGePg
 6ZOngdSikQMIyWdgpTsq87p58SuwdL6FcC0QPxh6sWVMcWQ9cKHkXQuWwudkRVxfjKJLIL2dc17
 /OVB4BVApcGxK8fZ8zgs8lzDoWN4v2bKey1K3lkZpgGy
X-Received: by 2002:a05:6a00:b80c:b0:899:74d0:8a72 with SMTP id
 d2e1a72fcca58-8c87d90393dmr16272024b3a.59.1795605238767; 
 Wed, 25 Nov 2026 03:13:58 -0800 (PST)
Received: from Sun ([240e:3a2:dcf:f2e0:899d:6e37:7d6d:4dce])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e4af1fsm8858969b3a.28.2026.11.25.03.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:13:58 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: vigneshr@ti.com, takahiro.kuwano@infineon.com, trini@konsulko.com,
 vjardin@free.fr, Jacky_guo@xmcwh.com, hs@nabladev.com,
 Ssunk <ssunkkan@gmail.com>
Subject: [PATCH v2] mtd: spi-nor: Update XM25QU512C to XM25QU512D
Date: Wed, 25 Nov 2026 19:13:51 +0800
Message-ID: <20261125111352.1861-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.4
In-Reply-To: <20261124123624.471-1-ssunkkan@gmail.com>
References: <20261124123624.471-1-ssunkkan@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 13:18:12 +0000
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

The XM25QU512C has been discontinued by XMC and replaced by
XM25QU512D. Both parts share the same JEDEC ID (0x204120)
and are compatible with the existing SPI NOR configuration.

Update the flash name to reflect the part currently in
production.

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---

Notes (patch-notes):
    Reference PCN document for the replacement:
    https://drive.google.com/file/d/1RR90EaWHKFVZMQrqLorMjc4brIkE0TM7/view?usp=sharing
    
    The latest XM25QU512D datasheet (Rev1.6, dated 2026/11/23)
    confirms support for 4-byte Quad Input Page Program (34h)
    on page 63 and in the SFDP 4-Byte Address Instruction Table
    on page 87.
    
    The datasheet currently available on XMC's website is an older
    revision. XMC will publish the updated revision in a future
    quarterly update.
    
    Current public datasheet:
    https://www.xmcwh.com/uploads/976/XM25QU512D_Ver1.0.pdf
    
    Changes in v2:
    - Rebase onto the next branch as requested by Tom Rini.
    - Update the flash name in xmc.c following the SPI NOR
      manufacturer driver refactoring.

 drivers/mtd/spi/xmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/xmc.c b/drivers/mtd/spi/xmc.c
index dbf11a4c5d3..ec98e3fb388 100644
--- a/drivers/mtd/spi/xmc.c
+++ b/drivers/mtd/spi/xmc.c
@@ -17,7 +17,7 @@ static const struct flash_info xmc_nor_parts[] = {
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH512D", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QU512D", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 };
 
-- 
2.55.0.windows.4

