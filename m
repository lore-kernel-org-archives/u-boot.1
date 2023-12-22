Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7B6C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 20:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E12869F6;
	Fri, 22 Dec 2023 21:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NAWXCw2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2216986BA8; Fri, 22 Dec 2023 21:16:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A1C86611
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 21:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703276187; x=1703880987; i=xypron.glpk@gmx.de;
 bh=5gko8YhLDnHiZj2VIXDQFGXfSNsSo0H4Zn6w8AiXDkE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=NAWXCw2fCKTwP3gwEu42/fV7oWouKimiGR1U9pIfNMdQhlPso+AEDkDOPGq2xz3c
 VOtzrSM6DYbKyMab51r4wPFu+gw01nMESbr/j3MK9hBg2V0hwkH9/dylHsc0e2SqD
 sjnwH0J3axcJ5TWskGz5vFQPemSsIhRbZ4EIyrFvC0ZQA6JBOHRVGfE+YHnhi57Iz
 O4swhQjqESWo4LEls5LxKfVdo3yKpXSSFtS2vYfn+BgjbQ9ikvmHyL/QvS4MuC2/D
 It7VOl5hJodQffzSs1t+6b7TjNDpmsgIMxPCk/W8kKKtHJ8zKeSDSYA6KmzVwokO1
 j0m8A+jNeaigLfzdWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1qwFlt2v7u-00qTtL; Fri, 22
 Dec 2023 21:16:27 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] smbios: type2: contained object handles
Date: Fri, 22 Dec 2023 21:16:17 +0100
Message-ID: <20231222201617.79950-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:12h1Edd0u9UgPp307ZeCx9NWdjtQeS5m8DhAbB8eUspUZmnvVpF
 oyIQkmhatWadduulFAkgjjTHjyRNE/2N6yDz1PWigkr9Y9B1KmOjRFNwJf5t1E/71oeXhvH
 GaYeUDdMM5JmrzKyX0svcRo+GxiEU0ztxNqcscJ6K3Wpac7JGl7LxPNa6b9fNszXxnKqjqW
 oqButmN6mdJLelj46LqLQ==
UI-OutboundReport: notjunk:1;M01:P0:yalBntSRKRE=;WQfgDwajvtnykzbFl+yXkDePoZp
 ke/HiNGMR1ajoj4k/6DENXSqxUQDIcSJWCCiM7e54SnnJYZH4Y3OXKj6XotkqkNJ+D3mh4vnY
 XC7EY7737ZkjJyyhZVxtQ8JtLNLg0CDTkmbPUsEC3TAC7WiEvVLgwNMzepf2fwQUR2RUXRcs4
 Y0NqTUtfnp/UPN7IdiGpi8wodjdo8ZX+RHLNWQMBrJUXcaF1aca93HbN5PtigRYNVErIuSefe
 KOLDq056RZDVCl3iXUiksB1qIruR+UaPR6AcRNPOCb0UWZmn2JjCJEJWfYkTawlOZ0OxQjDe/
 i0I1l4bYD7kUM/v1T3V1vWwgfUr/KPAKsihIZBxVMFeSssBeoDFaK5kNsSGMbwBG+GJyE07Wb
 HTLVEkr1ZnbCV3JvxJdFk6b3ZysePb+4Y3OhIgHzAw/7QaRo1mY53Q3uIJaEd08FLd/NVWNwp
 +bdnDTLuBwaDEcvT2KvlvWgdGcA7ztsO1LOSs1v8pjVjjUgPfuuSX3LOgqqLUCE9w95CacdjE
 m27fbLHXmOU4ymvj/0a4cDtOdSIYSkJbCcZIpfiH5sw8oi/9HB7kCfseVCPPiyTfMbKYZZFaB
 VbPacfvXIUTeM4w63h8/KjQEYU73eUKLbj6vUftyqmVvBWBjt/cRrAXb+n5GSpjnJOAQVOEy5
 3nPxoUhmB/Nr7KbuYSUYQp2NRHg5GZ3EFtU5B4/kclNbDyR2/Y01N0Gp+YcGCgH69WWBNWF41
 rHHXyszRA9Wofff/1agUP1J/5y/wb1ZJ52Kb9prOWYXbdkGzPwoi3+r7TchGULLRhnzuYKj/9
 rmaDp+4+C8TVyANuEKrPGh4fuQyMicfr2lD1hORoGbwDvqmuB3xQj2E7oxcUjE0VIc+Hl1AgM
 D7gqttM1ndnNEG9ERa/Kj1oftnV8jjdUL4DcksjizC7Q0asznrRggjgdvNtwHs2KaPx1RgryN
 TpdRWTXU/gPYhIfApZT6ge5HwJo=
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

The type 2 structure must include information about the contained objects.
It is fine to set the number of contained object handles to 0.

Add the missing field.

Fixes: 721e992a8af5 ("x86: Add SMBIOS table support")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 include/smbios.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/smbios.h b/include/smbios.h
index e601283d29..88c19ae062 100644
=2D-- a/include/smbios.h
+++ b/include/smbios.h
@@ -139,6 +139,7 @@ struct __packed smbios_type2 {
 	u8 chassis_location;
 	u16 chassis_handle;
 	u8 board_type;
+	u8 number_contained_objects;
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };

=2D-
2.43.0

