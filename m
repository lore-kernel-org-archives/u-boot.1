Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A3606A32C
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aeoNcu/G;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ik/0/GBc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0074811FE;
	Fri, 23 Oct 2026 19:00:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UMZ76M-Lm58e; Fri, 23 Oct 2026 19:00:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F1F3481181
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792782050;
	b=kH8FixG20xD9Sf3iKRjyz1jwiqy9guECwHkTuB54v3ikQzOtaXjFo3JtSRoF8/YMey7m
	 Yr4upEZLZeJuPIUkKap5/g1TK1UPiy2yQoXqtiSdZw/ezoCbGVaAC0fLaRN99+2XSK4YE
	 u+s2jW0pRyLy/GkUQ0X80/ZQeENq8zD//qc9xatXkpU8vqwnQc3W+WbQdeH9umKzx4Cce
	 zDixw0zXwpwxfJBN6AKhVbD9R3YDGANe5G7RUJJSl+GBi+4T2e0yBUgIoik4/Ti18Qg/z
	 NL1MqvrCHZ7w+v+ah3lRQ880F5OLH/n+CVUFRO6tX1p1YjwBp/FcWbPD/1PTXBPV9jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792782050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
	b=tWiXhx14x+b4JV9i3tOaF850fxGk5dvgXasMi0xjoCqfbMfHM/ClVXOdbo44rFLznEcL
	 ss+43lC+9CE2lXWrystxyj0GHJ989pDeuhR3lUM6yMffQZ9G1sWqJZZKgro88KekxRwYJ
	 dIX7e7tQKwsjQeSy1fpUJ5hVCG/6dnOsblHNWQlu4Kjwcbooa7sOmdfK2NqXYV1G/xHys
	 DTQiiB2rJX8XXjX9qRAdykcwCZV0wVkzMwt63CqtOSBePCgeTFHQR1H4UturxRFSON17F
	 Qf6IiYqQVOhBse1PDoree+d4Y8fCMlAQl7ER/wdWmxncP1QYj2/C/CoKY3vDAzEztHQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792782050;
	bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aeoNcu/GSXpXqsMLA5nsiJyafWr++qQSX2XfxP4kBW6ImaGjurU1MdwsaFygsBXHe
	 fx24JjoQmEvZjjUvkqvY1ALfFEzf3FlStDoKf5XmuqmMGrX0SdCbcjjpHdLIskz5JI
	 bhcBir8ixer6bg5ryl11mZrv8y4OAmtawfoJaauDnJEm5kopwIeTKJRZJY4Ybv4Qzd
	 DnImWDLAzOuCPdVEkRWVnbjwN597pJhdSida6wzRLeTG9qEKTfIbcafkQhwDH0uhTT
	 Z0F3zZtBoAviOmcwwCNh3sNB72UlOjiJSgXfmZ4pVDKYKpfbmT5T4J4rmc0o7ImRQk
	 9YHEscmkF4ZZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1F3481181;
	Fri, 23 Oct 2026 19:00:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 069D579F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC1E960A39
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S8xJD9Z3dJfs for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 19:00:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA83D608FC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792782046;
 b=VaR6w+XicxNmUCgHJUTL1UJ2eC3wgEPKkZxSIpRP/NkPuN71hbOjV2yKDHfgxHxWYe9F
 IRkkp1aCfn4ffyXkVzpjwoEYHMUB38wMJzFHWu1ca6CLoVT1JTrpJUQuqs4DI7AyU+qFi
 qRM3uFfaevgq3LnLnUXTh28PjKHX+k/9eEaH4s6Qw//wQByXPXvmGRgGMZDqBfAfCN6FZ
 KgNAVrD5IbCMqQKfAuLBDYUZwD2lM+b7gkTwHVMeNqWCKWuj1AUbEm4cs5PsY/aElTwEi
 Qm2vH5bq76rZ3AfWrG9VOQchVlOg4ZlmS50WH9r6bkwpgdpbSeR4zpfZOs5cqPbWwSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792782046;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=jWvaNPzAhXdDmAAo/GzdP9n102GuaBsswpGdWbc6LOZaXAL1eZ2PLB4Tih4yOXmAfjlB
 XbtKEPXTWOzw5OS+1J4sTITYsiYq9kDX2nnwQc0O800s5//6Z7JtJfSPcca29qyEaaw/G
 8cfovhOTPDvRvUIUKvgyAAKOsyab5XX+Vf2phXbTtHVUvJHHqexZafi4B/6PRo0BJ8hKi
 yYJMHyLE83YjLsLnVn15I2i2LV6RxMHE8hCM7EdtnmwN2Q+ZdjBHiRV2Ye0KFtcBviaGA
 sjYCYjdf1nvLT943dCBH/1AJCp1wlSXCS8/oCuF4eCxrobqn23ry3OtgzIbQLWN3NxQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Ik/0/GBc"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ik/0/GBc
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA83D608FC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:45 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so9523655e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792782043; x=1793386843;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=Ik/0/GBcVDoc9/GGs0Y+aQkiMG1vWYspJ7MJ/ZFfG2zBz2B+zNfAfddDhyMhFXuWSY
 r4Qn6Nv50lidJTJbvx4R+mlVqIpcep3Wi/fxIrZKUYelr/cKIq7xhATvPdINQ0++vyDU
 uc9LwxYyXxHWLMNCI0KcRmqRExSGrOaqo3U9BHJHt/ZW/B+QFLHvQC8W+HDrGuoVBDfP
 8vFyG6bTPwSu4VmArDyQMoD87TceyzE3XiOalLZJsXaVl4r3D7Ji0T2PBXh9UQyC2h06
 qwsAesGsgU1j74k5IrcFa43+cYiTpJc+t1vReceab5Q3Y/2lK6ZlH3Y2+aZ4ujMOZACC
 oVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792782043; x=1793386843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=x9gGLui/EmjFfa5drCwdmiWU4IVfAoQe5vpf5R37qDi87DPPz4vUFPWgVEm44vjPiU
 KDRS0lzgf9MF1apQZhAZdyuHluHdZy0rdYKnWbluO+Nbf4Tze6PRjXDenIrb51x1NkUB
 fE0U+DJD/ABezdZXc27YshpgmPUy6goNIdZpECiIWLyHRUCcTOMsmpx6i9YyX0cwerVU
 fR3p185xVqp/isiX50KQ3aalVJDzyJgVZ8ui3wsgUloZVgqQarw311/+xe+/DfvSlOWH
 rCdOZM1WFpanrBn4fVWnUg1NEymTVvMw98wLh8TD4wUQ4vTS5AuUpsBg1wf2yhog5DTF
 fY0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwklpK0GlXwZF7Ct0Gu01bqLgQ1lP4IqF1+xm0LXzPbmxj6/cQeN9FwQe4qI3UQ7nrhzdQ5yLo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJScNz1RKuOrqDYotc+IKuPhpXcNCXIf2v3pK8j+wr/dwjh3rNX
 lK9tNAx1sRqw6jXjxlc68dCjT7l2OGHIBM7YjK54PlVsFDBv785Yn82i
X-Gm-Gg: AYBFou1r6zuGr0pp5+LT7I24WcH7wxrWv0xYkMdRiuXNDt0rRp0uPYueysQw3IyMru9
 OI6J7qCKDCBtJIu0BEcM1/WzgmxgCEtel9w7UP/JIkHUXQy3qj++CAlCk4xUBseeFQNWjJdCwN5
 ue6fE9WvCs65O2t7zx5PqfaeGilAOutuui7kNIMfsGFIwE4x4LIcZxWUILTmixIb2gEECJ06/kh
 uGvAvn32B3Y7xxwomzAlrUPtNjEpLKBOQ8eTfSai2UXbqZVhCcGqltJzm5jRABjrVlE1X+7bU1Q
 1XXYIgSvalM0cUMVaIYUnkC0RIzxYz5Lhi7nXGq7StQ0WKJirJ2i1HpAseG0zHyngVPUnJ2dE/G
 eqpgQpQI7hv9plgoZZjR4I0TrZSyVmTX/rzlSpOS/+XDgaq6gJFGF+u44glPiXlNi6bIbwN3K1w
 b3owrrk//p7sAmgzZysTKvtKGOTrEFgCYerPsBkjhNsWdh26tqvcRbmWhFknCgWViELMglbtKTw
 axNqQCaAViWEmgKP41JWNXBV0S8hcgBsV9VrlawBtMFu1rrNCBT+HCYS0VqOiD7J/zM5dUWtxpD
 xmQh+DYb+82XG6BdrH5dZeOnYv1YmteOnAYQ/HdRIuz7Rwmi8JBBvhMyIL0c
X-Received: by 2002:a05:600c:348a:b0:4a2:180b:3153 with SMTP id
 5b1f17b1804b1-4a2180b36d6mr34936275e9.14.1792782043062; 
 Fri, 23 Oct 2026 12:00:43 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa097sm2481275e9.3.2026.10.23.12.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:00:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>, Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v9 1/8] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Fri, 23 Oct 2026 21:00:22 +0200
Message-ID: <20261023190034.911023-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023190034.911023-1-ansuelsmth@gmail.com>
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When dev_get_priv errors out, the ubifs is not umounted (if used).

Correctly handle this handle condition and while at it also return -EINVAL
instead of -ENOMEM as a better error since no memory is allocated but is
actually an invalid scenario for fw_get_filesystem_firmware().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/misc/fs_loader.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 6af4c7f15e7b..cd4695b08eea 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -175,8 +175,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 
 	struct firmware *firmwarep = dev_get_priv(dev);
 
-	if (!firmwarep)
-		return -ENOMEM;
+	if (!firmwarep) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
 			firmwarep->offset, firmwarep->size, &actread);
-- 
2.55.0

