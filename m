Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037A606A32C
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a+bdNgr8;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=J9demun/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A58D80D5E;
	Mon, 26 Oct 2026 21:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JvvyYlkvkJ-B; Mon, 26 Oct 2026 21:31:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D11180CD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050295;
	b=Xu88+f3WicnHdqh1xGss0fMN+oHYKR90PIxay4NMUGnMlrMMo44JSPXHDwgGDhsSE8Xx
	 eVoFs4swDRDp5Jj+SSfwt2/rzm8GC/aCuixvM1floq6NT+O4ZKFWlYNqxJMopSHrMkd41
	 SL6zRJDO8FaBGEKIXnAdHhMTgj//bpyqF5K5CD2v9BC7lRb791weIfTGET87zKPqh21wI
	 QxAzubh1/oQtP1ovHUf6hJ7zf3+ox9OF1kB6jmQaokD0jyw5E6OVs2i918o+HJRX+3hq9
	 mzOMsWfUaO0Jj2ajwy36BA82WCA2xEAbeVdjgFqC83pAuziBZKMyhgAFghSwpuY40+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MhwhPN6eY+k8B9cZpiAJ5epfRXQ0Ue9hQEKzJ/FAHq8=;
	b=OtP5WGmr8NkscGZamhdDxEgeNFtRoapfkXqAR2S33XUaWX+/axA6bHlxsxrGM5xn8snB
	 +Kh5+eT3jYSTngfVfMGlRBdzrZoyW/AB0OzNfM0Sumd9o7n079MJNeslUhDcy0jfEpkjd
	 4SOX5Z5zhfkB/Y0coFw7Gu3NKLLpxcBgDWt0gG8WFx4rYN9AK2c6xUUpYS1njHRw6ui/G
	 Hf7fWWzobfhn4KIV7d5uL99lc9DrU5rGXcU5F+BsukCaeRV0gFY1m8Sx2hzb9jLNREJyK
	 tQa5slw3kKFg6u/f2iqKOHEhyvOnHlHkeZEFqjsO1m8HqEewYk8hRgX+gYfF+QECM8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050295;
	bh=MhwhPN6eY+k8B9cZpiAJ5epfRXQ0Ue9hQEKzJ/FAHq8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a+bdNgr8+hnzf8miJZVX6NJ0yRdDg6/uzjrLrQtapOi005PRmblcjXJiPjxWSZ7pJ
	 U476fm1SstmsVMnEB9aJsfwMO7jDsOW9Qg6HubZUDm5TF5I0UI/1Gua96RFxPxDEb2
	 kd1Gs6e8Kn52tnuGz/a1avdJGZDZTs9KI1Gzh3LI7RenDEnLVMMFpYBXMH1jHgheO/
	 DCTJHHs2SGHvEMWlD6oXyzQqq8Qt5KLfBzv40Jyp5+LsOtPKpkLC4vXykd+2gCzIt4
	 uNMXikF0Bt1Flhj0xusBWziXVnXeZL7ZQD/agqE2EZWwhYoRU1A5GlEt50coIZY0vr
	 9Ph9KZ22qj8Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D11180CD3;
	Mon, 26 Oct 2026 21:31:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 95E314BC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C5CC40075
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mLoiZQUcnJyG for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:31:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2A92640062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050287;
 b=GCGMBkObYke+HBtSos9OXvx1rTFKstunapalI/9wrvK9vukeia5mda22xtolhmnFVig9
 jQ8O//GV4QD1XP9LzHA8qkOZ0wkO8rixN8nJ5gjIoni7lnWJAKZYBJh52pxZTNZzIcxtW
 IGmi9d++4IDyGDy8jaHvSXUlk7U0WOGswjwSQCME7bJihwDVOdB/XiIKDg1zvzvq6vfvU
 vm4gqdP+G0r0u64YIHe4SUKBVTpq/2NyMNEziwGtis1N2v/YXHB1bHpQ7DftDXM5Z7Dss
 iwXYKrcnuseTI2KeCBAS0tvF1KAzBSdJOEoj7MstQ4bwdPYaPAl6DahyPokv4qJIMIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050287;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-ID:X-MBO-RS-META;
 bh=MhwhPN6eY+k8B9cZpiAJ5epfRXQ0Ue9hQEKzJ/FAHq8=;
 b=jy7DcTXsqZV8tLw+b7jlc8DUmUOEmhJ5L8LGGWcZfegMIKHC7VX3Lql6gIKchtw/6AJh
 /BezJ1OBN9EmxOMQZUr2kcpri5JH7rGaKvYTwEQjA510ddcT7SKagFnttNXTEuUeUVZ90
 Dte0d9yhqGYlQd5xQ7aQVTHmMjbUTLmKEZplbFju7oNdhasNotdkcyDecp6+xsbWDcb99
 qn6TWBrKrxgAtadzD/ce4QSbU+rkyGhdJS4W+uWzZnbuSP2XQecpNYF5uxxXbgWoF6G6+
 j292ZEqmTSnsDtvW4rXUizLZmQ0iEqsxrIVCWaSCkwQL3VuHXxAcGrQejJeGqvCe5zQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="J9demun/"; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=J9demun/
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A92640062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:25 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jD6JB1Ryhz8tdk;
 Mon, 26 Oct 2026 22:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793050282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MhwhPN6eY+k8B9cZpiAJ5epfRXQ0Ue9hQEKzJ/FAHq8=;
 b=J9demun/YpbAFu3ZdJpkfIVT00jzXuJ5wWytoqAv+766ZTmpfE4L/cmYuKvI00rmWWotIU
 RXww4sT0E83J467dcYHELC8rmD6OfHmf7HPJwWaJ/fFxxEs8NKgavR5EJLzofk2VcuVK4l
 kfiHpV2neMqYoJmj3JUbCC+0ZcRWuScZ0VyOZvtlbyv/HwfA+tOTWQtPKnJ7MN1kyaMuJj
 Usff8196cLYrppJ/ho4Cmi0GWXsGRpzySxpVg3vFlLe25G8IA3tEhR8O/sy0S8JRD55GlD
 il6Hg99y4TtHVUPuq+1zC5oS/nsN4JHPCAti4RVgB4/peYjPsXAqly2/xmK5NA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] clk: renesas: Add Kconfig symbol for conditional build of
 full clock tables
Date: Mon, 26 Oct 2026 22:30:16 +0100
Message-ID: <20261026213111.453322-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7e0ba0d2e1f61115e2a
X-MBO-RS-META: gui93dagp48gc44yacj49qeuqxse4ui8
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

By default the clock tables used by U-Boot are reduced to keep the
size of the bootloader low. This option allows build of full clock
tables the same way they are included in the Linux kernel. This
includes clock entries for Audio, CAN, CANFD, DU, INTC, INTC-EX,
MSIOF, PWM, SSI, for which there is no U-Boot driver. This option
is disabled by default.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/renesas/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 1893b6c4181..15462280c60 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -4,6 +4,16 @@ config CLK_RENESAS
 	help
 	  Enable support for clock present on Renesas SoCs.
 
+config CLK_RENESAS_FULL
+	bool "Renesas clock drivers (full size)"
+	depends on CLK_RENESAS
+	help
+	  By default the clock tables used by U-Boot are reduced to keep the
+	  size of the bootloader low. Enable this option to use full clock
+	  tables the same way they are included in the Linux kernel. This
+	  includes clock entries for Audio, CAN, CANFD, DU, INTC, INTC-EX,
+	  MSIOF, PWM, SSI, for which there is no U-Boot driver.
+
 config CLK_RCAR
 	bool "Renesas R-Car clock driver support"
 	help
-- 
2.53.0

