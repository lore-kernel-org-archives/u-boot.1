Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169C7C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 12:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87DB280C8F;
	Mon,  7 Sep 2026 12:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QK2ZNEbHfBbl; Mon,  7 Sep 2026 12:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A312B80C8A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788783402;
	b=kPugeyMz7A9BouR/kf107Z7WYnjGavwkyUaVya6TfqYq8qXr7fCvVDK9PWdPI1jRQRLW
	 1ZR55jr2EhxVokU7m6QhLdLI60Ypk4N4ytxXzPgbtAwwB8M0VQjS32nqWPYSJIAMnwXDu
	 ry1ModxxYYwlJCQvyKCTA4GAwWCIOpHNIIY3XhpTCTv6frGz0271Y/Hj86gl2E9hfmyTX
	 9SKihT/mKReHCD4zxZl8PNmw4C6YYY092gVF2xzpXkd+bh5aYPPZmdSvOqASPq9juduhg
	 HbxTWLT3BtA/1AxhhiCJ8S47vomqSn3ezu02hkyT19ySNfVIlc8cEJoD3mSQzPsUDag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788783402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aCCZ9leHTYpi8oxUFVsMsnoauohn8BloothKT8kv1CE=;
	b=PY3qlupC3GHwPov3rJe+ETKN5yyVH4i8905AoPMeDPZSxZl6Q08zABf4O/+M6v1j3L3d
	 7fNX1qY3ZvEGL/VSGPCtVYDKHjriq5acJi2L6OZ+Kpug4oghbFV0FrT8CIi72uS0TB/LP
	 nA61bypL2pfJETjN46/DzuhsjdqfzI7F9n2INeJ9Ncixzzu4qEeBmVRxivFLTCjAOldG5
	 D6brrhKEy25/yeWmexhiXy9naBmHHNkZBl/JYwMa/8IPAP0IR3MREu+qu4Hbem8coRTIz
	 fdOnstTPjqK0ugW7ShjlTzhWnWBQz4pYlsgi1ahYdn5LzhbdB7WgFGeYKtFYC13M6Bw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FcNC2nx3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788783402;
	bh=aCCZ9leHTYpi8oxUFVsMsnoauohn8BloothKT8kv1CE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QHv9d/kxNhxH2xMdGRtLELvYvlH2jq+1RxqkHWHHbL6l9GzgZJREqqRibYE1Jdt3j
	 AMAW3f8X+79LWt8XETgJL+8gM44G4/bl1vvXf0ZbXKIW4wg8BqWkDBh+bluhYJorbv
	 /UftnMkn4CYXT0Wyp1zhyAPtmTYk4qYxfpHhmKTNiEZ217Pj8OdHqzMPN7Sq2ceptX
	 S5P8tYTG4lLfLiaFbHfMpWZeh0FBLTWILJcctt5zXPAHkXwc6YqVWsyaygyEA/+ekT
	 lDzJM7yDjh+vdiWLVT/Rp7pnBQme+wJPrNZtfq7eJ58hH9Rl44Ro+4WX3hfUyiA2o9
	 kb12CqSfZLBdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A312B80C8A;
	Mon,  7 Sep 2026 12:16:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20B53AEB
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E45C80C8A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2CFkqbBR__9 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 12:16:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 46B82809D3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788783400;
 b=Thkp5yF47U1zDgw3v6OC5ZSeR3fHwoV3g2WZljSAn+DQ26+Aez8fTZ0QdzaRhwdKwqWQ
 6OUvAhvkzCXrTT+QH60/jzxmBwU03kDRXmaxcdVpVxJF6o97KrsT5bThTnhpze5Q47B6D
 1BDlqvPuIZ+Uz0u+AyaeX/+YFWe8Cpv4MTr//JtOH9G3LuvohmZkFZ3+rU4y4WfUnbmsa
 pIM4F22Ienq8xmOBX+LUUoZIlfrFL1UQ+7hQ7K4w3YgjvfgDpIcRRtJ/DIcIJYTRGWSBo
 bVcu/FDDPKZ+Q/VrucnMAz6DuASSuoMrbBH6j2ZcqlWWWn95RW5InoPEMxmWXDoUB2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788783400;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=aCCZ9leHTYpi8oxUFVsMsnoauohn8BloothKT8kv1CE=;
 b=G1oO89B8+gu1Fqqrzd1D746s08SyT0Rzc67mKpiMFpJB0Jn066Hg8rDOE6jBaoGZWRf3
 zbujBLqTrICaH/lsA7BptMnXtPan3RdszPSrmQAPPHbeZUnxny8DGgYpIE+td4cxvhb2R
 XNWH1H1In8CLUItogo3eYcoXYfGNtZA4mszX40fidJjEa66+vT4GAJ81BXMMB1Co14Q/2
 Yz1ah3ymULiZa1Zm7O9TU3MX5maYcClGgMVP6ulROEwLPS7OXXi3Ur9GPa1fi2XpeikE3
 Yp8X47e7UE047dRtOJCvjfRgycPzYAkezZ+ZqVZjJEyQPWP0SXwKWTsxoVYF90dO0HQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=FcNC2nx3; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=FcNC2nx3
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46B82809D3
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:16:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E660E1476;
 Mon,  7 Sep 2026 05:16:33 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 996F23F7D8;
 Mon,  7 Sep 2026 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1788783397; bh=BHmFsbSR15e3Ks8snsfUEkENZLwdmnqqVyZFHHypN0E=;
 h=From:Date:Subject:To:Cc:From;
 b=FcNC2nx3Hml+1Lkl1/SYt87kcH3bLQZY7ti5g1/sC246R12JmwDvHRiiJkDcl36C3
 c1DWxUMIKY/42PDJkuB/EnV9Tg7F2eADg0eByqRE7Ys1DVy4k3K4+FUoICPBpw/VzQ
 +UdL02mxjaEdoOreuQCmCENPd0cF5bA9SAf20vhE=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Mon, 07 Sep 2026 14:16:34 +0200
Subject: [PATCH] efi_loader: pass GUID by address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-guidptr-v1-1-5cb72c450436@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwNz3fTSzJSCkiJdSwsz0xSDNIOUFMMkJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAGwWH0VrAAAA
X-Change-ID: 20260907-guidptr-9865d0f0dd1b
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=BHmFsbSR15e3Ks8snsfUEkENZLwdmnqqVyZFHHypN0E=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqnqsk6oV4Q86udtL8pQ2+Bc4p+VWQr74q/wiHS
 xsY78CKENCJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCap6rJAAKCRDLSfhWdqMG
 lKH7B/0ajWKHk3lU/v4VerUMzT0/AD1yJ2IlhZu412M8BV0VA15cnQg69vzjcavAuuhQg6fd3aW
 vYjal4cOulgpnaBZflfvxTbITwdjGGrdvQR0AdlzI3qILzWyvwqZEzKRvFPyq+419lpk6NBGnM8
 aiD0eFIL4o4FlxbLEITGfwioy7LZUA9iQAQPIAgPAk4uJEDadMhf5Mjuc2x5OcRURRFVn/4dwxj
 GZojeDUY67FDKtwjuRfOv9maJeCdr0UBO3H08VRmsHl6syopN+8zZnD0NDmSeJMIBwidgX1lVAx
 ogB+H+QWiktcNWNDwWiYip3/mJzkLQGEJVKeNtaePV4U+y8P
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

Instead of passing a GUID by value to the hash_algo_supported()
function, prefer passing a pointer.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_loader/efi_signature.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index c2be5cb61b3..21a96426356 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -166,7 +166,7 @@ bool efi_hash_regions(struct image_region *regs, int count,
  *
  * Return: true if supported false otherwise
  */
-static bool hash_algo_supported(const efi_guid_t guid)
+static bool hash_algo_supported(const efi_guid_t *guid)
 {
 	int i;
 	const efi_guid_t unsupported_hashes[] = {
@@ -177,7 +177,7 @@ static bool hash_algo_supported(const efi_guid_t guid)
 	};
 
 	for (i = 0; i < ARRAY_SIZE(unsupported_hashes); i++) {
-		if (!guidcmp(&unsupported_hashes[i], &guid))
+		if (!guidcmp(&unsupported_hashes[i], guid))
 			return false;
 	}
 
@@ -219,7 +219,7 @@ bool efi_signature_lookup_digest(struct efi_image_regions *regs,
 		 * if the hash algorithm is unsupported and we get an entry in
 		 * dbx reject the image
 		 */
-		if (dbx && !hash_algo_supported(siglist->sig_type)) {
+		if (dbx && !hash_algo_supported(&siglist->sig_type)) {
 			found = true;
 			continue;
 		};

---
base-commit: 509312dc5386ff4c5adabf53a573abca0aac4ce5
change-id: 20260907-guidptr-9865d0f0dd1b

Best regards,
--  
Vincent.

