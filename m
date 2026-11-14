Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05FE606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VSn01APx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItARbsWr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEA716071D;
	Sat, 14 Nov 2026 04:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ZNZ6_vSNEAp; Sat, 14 Nov 2026 04:05:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0ED3F60E1A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629112;
	b=bZSfg1wdlICquqxlVTRpoJ2vpdITJ7bImleufZvot66zEPOKLCWydKHIaU/yK0t8dvm5
	 tb1acyKsQM07cmGAxX3fuCkgdtXB478pS0fnJk/Nq1J/R7BFmrb17U7cu6+WoVKUM8BkP
	 BuE2RbnwOCap+UsHvVqlU8PuyO3YQ6Shvt+LJJpVqMinZUzA3kycjw5F9k5TRiAmYjkSf
	 cWEqetxFCIJa7pPoFGzP5pTQk1hhYreKF9lHNqIG6NLZPEetRYBxApqjy1UEG62UhT1//
	 20DvlZ4jkk+Jg8M+SqYqY1pwIo8lKXkym7gaaFQ+OA+3OJb+3U/mZuHrB2e1hl1rj8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629112;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=jpDNCqlNiUdTQbiZAqlGE1cYzXEZ+gjwR8Cd0Be4aKI=;
	b=di3tYOa/8XvcMDuUHlnf2qBDUj3bw6kjyYof0C4fIJR/bpjdcXituOQZoYGWZCatxDas
	 czqwyG4Pag8FMluL/mypYynF0834LGqdiZmgGjT4GPoOAsRCvrMNbtfBUGVDaePy8Tiq3
	 jIkTr3ozUzX1YPRka4O1mNhtNi0kxK5CooRv/sP3BTtFMlPxtsugYH/lUJly0b+XQATxh
	 vMKyjxlRcTOnGQDDMV9rss4aKW+h2X7yFY6PERXXKuAve+l58fHQauXtXThNDmFOlkff7
	 84AgyOhI0eV3zLOajMvZFSNFAXHBof/5Nc4j7eVGB1x2yonuEvqWEwISXRvcERmVOdg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItARbsWr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629112;
	bh=jpDNCqlNiUdTQbiZAqlGE1cYzXEZ+gjwR8Cd0Be4aKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=VSn01APxNr2BLgBe1BNHXUZe21o34m4lM0+sPFxW6H5pybVRZiAekv+Sgu4ZzicKS
	 dZXoRjeYRae4V3xOJvwdn8KykZ0WEWn3e8bUSficK49YOJa7zC2OZs2XAs4xGCAmDW
	 ThapXdDevX1Sk3k20zriAayKP/bqShltnOWPsyPreichGhbIWNeK8BdiSunDLvwMEg
	 brX/ncaXvIuEHpzAil5gk9/xYGnA+/FAxuq4XYf+se9Ahak3XplWMSHOBopmOUvPFn
	 8nauikPbcCnnbS1jtSyen79BgJIY//TT4f0HZ5rV3tgRU+pTpx1zjTyY1EwvRiTEt7
	 OcmCTfD5XqTbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0ED3F60E1A;
	Sat, 14 Nov 2026 04:05:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 574F3150
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D49B60D80
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZby7PGvWKjR for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 655D7606F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+me.fromdisposition.org@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ItARbsWr
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 655D7606F1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DCA246411;
 Sat, 14 Nov 2026 02:22:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3AC311F000C6;
 Sat, 14 Nov 2026 02:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794622937;
 bh=jpDNCqlNiUdTQbiZAqlGE1cYzXEZ+gjwR8Cd0Be4aKI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ItARbsWrOfgMrnQ7dSDR2vKvIK3y/26rEHd8ICkp8q6TQemHfrLL9ZC/pMDnouJWa
 ymSpUU05TXyijcs4j/qaMmAh8bIjveKDNGY+N6wE8hAr1SVoiH0v0vwEflYlCbrRi8
 zasIGNucUu0jKo6VvQ5DjJZTmw0o/pYusWwZ+TVoXReWdW1v3Mi9aYAS5WZrlf4tlm
 It9FVMb6E7CwKZmHUrYVPA6B/IXK+szCCrVrcjuPPC/tjwNlvn9F4ZXD3UWC5wnEEk
 YRc79vpQOUSF8I+kZjTWBxfDGbqTlgb4B9arrkUSKkAUgZ0fsMJoNgkCgoE/1C4NPt
 TC//FRLFujBEQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BBA4A49C33;
 Sat, 14 Nov 2026 02:22:14 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Sat, 14 Nov 2026 02:21:59 +0000
Subject: [PATCH 5/9] gpio: qcom_spmi_gpio: add qcom,pm8350-gpio
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-sm8350-support-v1-5-414271f59474@fromdisposition.org>
References: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
In-Reply-To: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Erikas Bitovtas <xerikasxx@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Demeter Barna <me@fromdisposition.org>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794622936; l=841;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=ZTR5J5lSqNxrpMNOY94LkhfMSQh5ja0koATMHlss8Sg=;
 b=mtwE7JfwUjKe0Ytau5L0bsKKP66xehDfgsQ8rdEBNv3lOb//Vio/wjIjKstEahDFm8c89d4kz
 iljiDbcHZDLD4DEEoi0eCzKYZZsLkdM0DR00bIPKSsY0EROEEJsAB+Y
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 04:05:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: me@fromdisposition.org
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Demeter Barna <me@fromdisposition.org>

PM8350 has the same GPIO block as the other PMICs of the family.

The Razer Edge 5G wires its Volume Up key to one of its pins.

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index d06b9a4b51..0254d7de78 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -749,6 +749,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
 	{ .compatible = "qcom,pm7325-gpio" },
 	{ .compatible = "qcom,pm7550-gpio" },
 	{ .compatible = "qcom,pm8150l-gpio" },
+	{ .compatible = "qcom,pm8350-gpio" },
 	{ .compatible = "qcom,pm8550-gpio" },
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },

-- 
2.53.0


