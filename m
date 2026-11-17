Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89265606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y7BTX0oL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muMol6SZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF9C460889;
	Tue, 17 Nov 2026 12:27:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G1x6q5KVUBTc; Tue, 17 Nov 2026 12:27:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C3B56085D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794918449;
	b=kcMHJSxB6tFqzVeEvXGP1I4edHKqAzLGgaJIy3eHnLlMvEFD+e5fQiPAAVWLnx6M0tm5
	 XF0q1KHogrTc0lY1668k98vOo7AZSnz8uIGmug+/SFlbgjgcFMbOqUJwHywqErZzG0Ob6
	 G3GHlTv9s5UFOj26nNIxOSgQ1Fw3kPeNLlFXLdTyNBKjINQgK2TDOC7yX6Whr6zFgM544
	 +vlNMZMMbPfo9CWsA+RREDj2SiU5stWdplv+/kBR2EQzbgUXPYzxAozHF9UNTd1eesvHt
	 H3fmJKH5bMozld2F4wK4vzQOTPIX3SJHzNSGjWy22bgKPqHu8ECBOfa5aHgw9oxr+3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794918449;
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
	b=tFIxjA+rTuywRIqMkd7w4bs587zaEIQuhwZ7F4kEJmCMI1u87ULX9/8DZ/ErYNbiuCuK
	 T1YD/RQDigHCjYIzahgudEegUpL1DmfYhm8eBw8H+I0k6TknOwwbjdnlUThEYRyI5R5SD
	 6IZGov37PXNCX9uLy4BsnhZdf7PGAcO5ItDEk84oGj8aVQ6tKWa24L+LORaPvjvs+yT6J
	 Q2vuuaOIfj49l+oaEH0zy0JnNmFNpB87f8X6PdW/v2bLwnwDEPLOrZ3zjqb++cmUQbwJ7
	 GxoD3lpBbBvCP1ofuV5obMT9pgz9SU8PbMmTaJxZiM+RkPS2pCtc8BOJibXdYg4+Swg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794918449;
	bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y7BTX0oLT9N9vgnNfOYH5tTP4nVC3NfPnAAuAIN3fXEqVwKf/Muzwcv92jJCkk+di
	 t5mRk6KIVYp0zgR9N24B/dBu4rbehAGAOBEH5+rjdpiNqTnCNKgdohZHXF2QKOVsap
	 edRez6QzLa1CqzygLHSAS7mfGGH1IyDw+Hv9XIG8Iw1GIlbxOmmF0SH1wo3kzdtLoy
	 HyQYeaO98aI9QCMttaDHbBU2DSAUP7NeuIzTC+WbVYEkFW7RX3uOk8MatDEeRtMpqP
	 dT8vv8sjs01AILLswaoFeaCSCmbQxXtzblB6t27900goNI1vqBOpEYFjiComL8cJlR
	 0Oj4KfEcuwXuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C3B56085D;
	Tue, 17 Nov 2026 12:27:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9B7C105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FA8780FC6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id otbp58paKr2i for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 12:27:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF91980FA9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=muMol6SZ
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF91980FA9
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:25 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so7570819a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 04:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794918443; x=1795523243;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=muMol6SZaixL3RDQsIP8PXmVShzB2B6i2OKLJ9enZokFLtD5dARVw9t/CgAWHQ+AkA
 +ji8yx5EGdF29js3Br1vK8QaV6Z1fEkpm2EiaDDPV/H4dcUu4vVlq6ELpJ4zIaR0MV9l
 NdZ4nkmJ16K/XwBuM9RQrMsZZvy6yDDwMw+pOXTN1WdMuAIozz3OMhYyR12W9/+cf+5M
 RMr5Qk4bcqm6gUEnSQyIK3k/YG2FN3no2V3GlWcg9zdBbOZbf6i/tJZ0ZkOVvTT7YtP0
 ccFZHw2eCLH+zwW1gBxAJTebqAyMwJd3bnRjcAuhRk+ly8BWl/Zify0JOkmZSA3B+cE7
 szQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918443; x=1795523243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=h+/ApfHB7ufEQjVx9++zM7wKFLeXIM6mcif+RhnGiqh9VwCFBPVyKnZhQO9UxvWykT
 k53D54uTGnFAa6wXPl1wW7FHkn9ljYos1ROECq5XVtQi+Jp3H0blaDnEkN+HSs9A5UvU
 34aYszm5uXOBe0Z1KKXIpUzTwOoppZQZ7EHLxGmenXYw7xhGiIwRacplWdGUNIhPXWIH
 q78/DBPRjYZcROYlez2iCvmRv7hRGSyj5+Qvz6JE4gdkZOoypbWQCel+nObVFB4pXoIW
 1GLvzfyj1RlcXgB+eC+7z19HSSfBgg/626NdfhLToEpJz9lNDafmO9OTzfxmBvSFJnTx
 5Hiw==
X-Forwarded-Encrypted: i=1;
 AL+hErHJcoa2SIL/WEtPKfKKpIupqN7X/YXNncLu/X10CmwzZYTbqMsdsd68dCrZq25SQi+iqjf+UmE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/gWhgcAzbOmzR7IFrpqnG5W2ArNVycRLQsa+DF6hmk1UVeEyc2
 Vaw+kKfrH3WJIHot4JbAGNhGHP7OhdC/Xxqg8P2A/IqwABj2yiXJvvbbKNwIkQ==
X-Gm-Gg: AYBFou2/aMySkLXzR6sM5nNCBf1wVMlUEHPrn9Jln4LsjVH/YYJg4fpXQsBJpJbTtYr
 berxeMFgLvSXrr5Fb1cm8eFkUH4lZjHc9KMFnTld5qvOf5pLkfX3Uh4Egw6WBN2D0UqhezI3u5r
 CmD0M0JJXXk8ESf9eegi+aD9B6BLR+fiPpN6iHylnytpZ0yzLuaq84nawRxYUP6LWN+igBU8BXo
 Gfb1k4Y1NHO0Ip6Kv9bVAAcihuzFXjZGd0SCB6BmQrmrYmEH8JFTzy6K/mf1jzfkGcmjezFVWw9
 TB/BOhvgRhOIVfIfkzoSK6EnVGlVKULftFuPQPy2FGugz2rwruTVdRqDPtBYakONoCZAZrr3idG
 /4VPr7+dKLNs0s0kp/910dFvfMguwv6Icbkx+BJNDOVco9jGkdT4uWQM/U0CqvWXJYrddKnnNgy
 a3J0gyKEpq+8cdSBDDzdHvMDygkzYh678nB24LA3Fo6jG0HFa2tBOUmtQoHRbLFSXl9RNW2dxBL
 QMH1AROTXXs+cNqYS0EnIhwJMxv3V6ekbNafjIeAGWxDoYPNoLNHTaXFzDrGrKQ5seEAMYWUOk4
 vbohaL4+Lbus10GVAaJhMco2+aMwSYl79GJyLqdus0aRnA/Sm1dbfkk/k263EiUXTLK11LEg+pk
 GMe2QVgpO97vIrAmleMp73FBsU0lPth2uaQ==
X-Received: by 2002:a05:6402:a513:10b0:6b5:8c80:d12d with SMTP id
 4fb4d7f45d1cf-6b7c0c4d305mr7270219a12.37.1794918443282; 
 Tue, 17 Nov 2026 04:27:23 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-92-103.ip49.fastwebnet.it.
 [93.34.92.103]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4a33c344a58sm5243151f8f.34.2026.11.17.04.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:27:22 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Michal Simek <michal.simek@amd.com>,
 Vincent Jardin <vjardin@free.fr>, Martin Schwan <m.schwan@phytec.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v12 1/9] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Tue, 17 Nov 2026 13:27:06 +0100
Message-ID: <20261117122715.7983-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117122715.7983-1-ansuelsmth@gmail.com>
References: <20261117122715.7983-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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

