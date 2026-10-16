Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB06CCA490
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 22:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5531840C65;
	Fri, 16 Oct 2026 22:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xKN9jSwzbeem; Fri, 16 Oct 2026 22:52:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8ECFF40B21
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792191140;
	b=iJiNH6cHIgMS7L21C5mSdA0EyztLF/EbCkB5Q+PUFayJxZ8t862W2zcbSZOIlUeyr7Gi
	 YVj1hY6f0OMPVMK8Vi8B3iZnbyWQmClL+Ei5HLWGSEQRlLnf6ciOEhVex8HbpPbE4IbXq
	 AYfQN0DDs9gYvJplsRCf2qYhRqBUsy2CpbJBw1VTPYJOdKTd2RH+gdymmmJE1EFx2OtrJ
	 JhSKhiLXKVQcs5BnCKAlurhKgUqdJeJuUXCe/QGXywZRk8nJxla/uKchlMQIIRJAKdSJ9
	 RYNTd0JND1yLnrxBFYJJQ6UAvmt3YngI5u74oJGQlfC1gLeGNZK4ae11JdA7BwKUg4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792191140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Kwr45LH75rpyGRPpkwn525foHxctH7bnh3q2yAE4tc0=;
	b=cZSfU9uTpMA2WxQOAPQEbmFwJ5iziD/ShHXMUekx0jHWIy5XxO6qtOHgkx2fL/Ng6Kdd
	 Jb53QAUo6cbZm3W8glCHkxwQ4nsfBxQdAhzNgwoBxcIQAbV31Rda6KzcK13uAkDAdKve+
	 U5XC8pr0YQh1a9sEYWvqmcbStB2vt5bBfcgD5wYwdrL+SzZzXDj5weq77y4C91y+FZ3Ya
	 vB4LBplOhf30XwnzjibF4wJWM+1SutqxeVzk2I55sbufkrGWEVsHTggyqfB9QS+ohw9ih
	 27b5z2h+I1Wigunn6ZnUr2aOIfpCrmvc0t2vWYwFUrPDnzlb8lcKTzHBcn5jBm0vh2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792191140;
	bh=Kwr45LH75rpyGRPpkwn525foHxctH7bnh3q2yAE4tc0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=K4rsje3L1fYyKiJKC743mrNQ+2bwc0O4zQbOdPQZIeXm4sc6nzzNjbz0+F8xm9h6t
	 IVvi4XYVY1LOyUdjVkyfh726Q941SwgHA+gYvvz06fktgy24/oAOVP6YzP78FIP6F4
	 IYextawxjBUApYvvR5wGRBpBm+1Gql3W1SWKD/TbTCzlPXfY/zfFk9pcpFZ1+NRT0A
	 O3YKN3gGWkeY4rtRacIT+JDfHSoO4frCk1WlNyVILDrKLLx+0lWwUUuSBkjqvMz1Rd
	 +vhPeg6vzjvRWYFFmPBaN9NaKiIIX5/07N+AGF3v7uRYNcKvZx8t32RradE/ZX04Ha
	 1+lZ1fVNLOylA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8ECFF40B21;
	Fri, 16 Oct 2026 22:52:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9677379D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88776404E8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qPzJr4WEIYWg for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 21:22:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F1888400D7
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792185766;
 b=FaVjO0fIlRsdcosvw6q5JSnzvGIZslUMoaLt0RAH25NQJZBLlLXNn1fw8BVFT6mDEMFN
 n0IQYzN581SoLN8CDy8BiVzSrDBS/S+Xb5ZXthKlXIs0uy/T1oyzG3um4U+kzBTKzb3Bv
 XiUp3LlyKkQVJivU/quWfgjpt3WbdpIUHDBDVApHB7tPdgBplqIR5ihSmlcb7CMLE1JAR
 5D6qn+qTpbTJP6LgFm9UgETeTHMy0tQJ3U689ByLWa5x4GjLIdHMDNzqdDAwsl/Q+SPxM
 QunYHupCD7yEmAFQk7ewh1Q4Kplf6u0Tfmdrb5bcr9S9Fch0zXUsO35sftBJWG6YJ/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792185766;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=Kwr45LH75rpyGRPpkwn525foHxctH7bnh3q2yAE4tc0=;
 b=WnKAR/6KX49s9526MXNKbZOH4mJ2MDV7vzbWERjjRUryAi+bXxdLvKIvZKk0rvDAemCN
 al7cxtVPAAOm30GhRw2oX4VhT25WlwMHAatCxBZew9OBaN3BnOJUk/TSbF1me4CUDqQt6
 wU7hdoSNQJzVUTGEdjZoGFjx9xCkamK9Mjfy3bGNroGKV+7TjaGW7g2lPOiapT33eV86N
 Z87Xj0Ou/2IQ5MFsVPue6uM98TOIR9Wcx+PiI7wcuUCRtl/eH1Py4W3PdEWOWegr52dE7
 kaA5Dk2pHFR8B0QXcNz87RZL2gqQwokWgWKGPuFtFygBk5FaMJRzeWLEWauDJCjs2iw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RxCymZ4g; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RxCymZ4g
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1888400D7
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:22:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F07C841881;
 Fri, 16 Oct 2026 21:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CADE3C2BCF4;
 Fri, 16 Oct 2026 21:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792185764;
 bh=GaLZr3EKMagyDE96nEufV99YxLykRqnZgtFAQGS699s=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=RxCymZ4glV1kj/YwDMKOq/hfME5re9Ef+cuwo0VGERE+j3/Z/dy0yqKC8lv47j3Xf
 z5JtUoqOmbKfq4OYOeXzT7Z5cYI4uPNPOFNbLc8/zzO+Ep0C8CL+XifSN5ctGOMm1T
 4Bnwi8F3WIIjY2hdLBWXNuCbuNcxzxDKbfkfvgatTSA1v790+k5CH7eVUI/OTeWl50
 ChChT9TOio3sL0qj87b4RxeW9CSQ++gB56bjk2hJjWT4eMU53gK+UO2xuTmZSeIHRF
 6f7IjN856AdjXrtp3pJJC3jiQPRcZdoQ163bnm4eks/BZ/9E5sP0O8xwmUVXNNJT0f
 6sZ0jDqPppWLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A5F5ACCF2C6;
 Fri, 16 Oct 2026 21:22:44 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 16 Oct 2026 23:22:40 +0200
Subject: [PATCH] gpio: qcom_spmi_gpio: add qcom,pm8150l-gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-pm8150l-gpio-v1-1-be7cfbe7e3b7@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mz3SQT3YJcC0NTgxzd9ILMfF1Ti2SjZIM0ixRz40QloK6CotS0zAq
 widGxEH5xaVJWanIJyBil2loAsZXVHHMAAAA=
X-Change-ID: 20261016-b4-pm8150l-gpio-58c2c0f8d73a
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 David Heidelberg <david@ixit.cz>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792185763; l=1178;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=2tV/8TYil6y28jB+wzHKibuaGkO0WDGs0SbuiholmVw=;
 b=uB2xYd67oQKeuMASDCxy7rMO5HiNRbHFj5zQt1WKHENAkUDRCLhB0UGwQzqdJcgk8gqzG4+30
 T/KPe4vrv2JBSiq3J4kpmy75tobOi2GJgp+NhvExePZSV8xG2sCxSgG
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 22:52:07 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

PM8150L has the same GPIO block as the other PMICs of the family.

The Pixel 4a 5G (bramble) wires its Volume Up key to one of its pins.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
The Pixel 4a 5G wires its Volume Up key to a PM8150L GPIO.

Without the compatible the PMIC GPIO block is not bound
so the key cannot be read in U-Boot.
---
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index ae75a4e151d..f4b614ee1a6 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -748,6 +748,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
 	{ .compatible = "qcom,pm660l-gpio" },
 	{ .compatible = "qcom,pm7325-gpio" },
 	{ .compatible = "qcom,pm7550-gpio" },
+	{ .compatible = "qcom,pm8150l-gpio" },
 	{ .compatible = "qcom,pm8550-gpio" },
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },

---
base-commit: 71433ebf2aed1be5fbd2b1d497eae670ab9b9962
change-id: 20261016-b4-pm8150l-gpio-58c2c0f8d73a

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


