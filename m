Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05685606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Dah8INIw;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zhW4Rpet
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FF878100F;
	Thu, 29 Oct 2026 17:42:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sH2IZ8CC0III; Thu, 29 Oct 2026 17:42:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B1F4E80FD8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295721;
	b=aCQQfLYqLHug73prbHcgbYx8dCNhDylxRtF71upXK7bxq/C9vD04Tk4FuEtJ0n9sw8Rq
	 YbiYviKJcBIVfXbENHg/pTFpiyS5w2JW2VPmM0LUkxBvJNvdLcBxQlbp/Jb2/K68vbE2j
	 OkjWephOVh442WQ37gxvC66AxDTM+j2djILhtjVWP09EbPJzuBwIaCk9DZ6VW8m9+4TUK
	 jZdJTd/oC+H3UaZO7yl/uphyeQ9XLOV8XnxaXPDRoI9oMw0wGaY9wX5m4jc2/s7t+KFjJ
	 J1mjnMqHGYhNOAivLZLDXdFEj97VUvQe14qYp08JLHkUye0aiQTvNYgQJqEe62hN0zQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yEnoz6ApqVmzT/uTxetRUr9MxvUJRlh3RJt8Aef9PB4=;
	b=eHJb9b9+/FfQE76If6fTRx6QVnW81hNxyK4CRHH655oHIKIiWnUAaCl0S2fmZchGpyi2
	 lCJVckWcvMbdkdMMKyN22gkYtx2WyV5zFlvz+Ly0E157iK4lOqV7pArX6CwjeDNiBosGn
	 TyRGcKBZbbNi3VG4Y/nfGZpT+PKu0sXxln9RHeBvrLXUrk3HrCIK1ysFfPfsMXE/jK1aw
	 HgsNJ9EI4ZZnfuzoAMxKf9A44e9aHQnsfEDT70hKoc6BFasuHzpFH8gAEzpMHG7UE0Vut
	 5t6liGeuFffTsmG0b85wbJ3eOSKK/0cE/8VW16dKHItOKNVGjTzhIsxiPa/KYLwU8Qg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zhW4Rpet;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295721;
	bh=yEnoz6ApqVmzT/uTxetRUr9MxvUJRlh3RJt8Aef9PB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dah8INIwj4GnjrMyKCYLDFtSaPwNQOyr855hYVTmBBh9Nv/U6MLquFX+T14AIEKzI
	 FjoS0gx21cjEEHHf/6F44KRZ7GiUvYFPMikJ9Y5kBBCkL5o8T29+OkYxyrCk+MNkvR
	 A8Y38ipi7qNHOxSMw4PIe2O/gstyduu7zWSyIEFcJZREc/Ytwa0BhB/ownTYoazyKF
	 4LOTcF0hjdLfIkZ43YafRGKBZnAkT3olvXcmcV4At9JE2MhQj3KNOwcHXFGbny3pFT
	 vZUGYqwMXphCMyAhbmoOgNsHJBad592ATHjH1JGHY4XaqVJkNw+mvptCsZJHRSFTaY
	 N/AL6XuURP1jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1F4E80FD8;
	Thu, 29 Oct 2026 17:42:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C2D3120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82E2A8101C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZ6rn7LKOnpJ for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:34:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9935A80F7A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295293;
 b=kg3MSCIq16hM1kdnCdEgGe26TOiTKIQL9AhPzLjdrHZQ+LI5affCOQfi7QBaAI5GqXW+
 2rjuLDo9FqOXbuaV7XZ3mSWxwb7Swpql7Lb7XX9yCV8eJdJUBd9Q5mr3IwFqqlSNq+DUS
 tqJpGxkbZkZBw14uQylYzlThPz8y0QtLMY0z7M8S6aKOAk8GAPpNNvItkU3NFQ4W93JhF
 u2oUMOj3YQRbFf92M4BZ3V19EqXYemanI53JPLbmciwcii2v6FSTEe/Fjf5gdiG4I8mvM
 DkIYSKcTVl4VXIAtlteNTWg8NyhedrTgrrPOs+NSOi3wSvGNFCTDtjWdBPTq2985Rew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295293;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=yEnoz6ApqVmzT/uTxetRUr9MxvUJRlh3RJt8Aef9PB4=;
 b=NHeNM/a7A9SDAORS9xU89sBefwKiucOBybi4t12kv2Z+ksbp90scN8DD3yPikn0/IW7M
 ZWel++Z2hQ9HlMGe+5h+6P7Oxu5mIayWsn23E8YOSTJdsPAupsEMgXMgQY29Ldc6eRCyr
 yr33tsClXazCyZmJv00ws16MqyksIneoF91is3h8OGGOuLtM6T2kSEklYF9UD4X4DsRnf
 WIOr615GwByLzADMvvqIq/aE3fdE6C1haSt1Nz3j/i2oF0TWkU/8+Lw+DxT+AVh4FPtWD
 ncZob0X0TxYdYGPU6IlaZDeIeEgVBdWKwbY3Z5lGQaAIxAwOWGL61vwBAnRZd0r6MDw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=zhW4Rpet; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=zhW4Rpet
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9935A80F7A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:34:52 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3ac97e45a79so18082071fa.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793295290; x=1793900090;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yEnoz6ApqVmzT/uTxetRUr9MxvUJRlh3RJt8Aef9PB4=;
 b=zhW4RpetVXVwixdbsHfVvtiRs7EyNFvPrv1ZIAO6zN++nU9C2dhXJ+vkQJce3zgX4C
 sZW7ZJNaJ5pEnKr5SEbnJUzZDE52+8w/hZ3Z4+YdYwEucZ2PNuucVpqvfAMxvijO1K8f
 IADspBC7fVpZ79BmbMDNAh+I7IHx5h8vOXuRrMW4XF6mAPTa9BMbIoz79DHKY600/Sph
 Baa6bzXQ2VQg4VsAGBbH4wvt47iKJTMK3SAuz48TFM+KcOuPzkbgOu9rwZUZef9LvB8U
 cZtVCSWNpcMOr8XtKhtxeBxjhuEmX0pOwib3gF/2POKQSIqC+tBLr7e1PkSkPpYYq/Uj
 6w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295290; x=1793900090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yEnoz6ApqVmzT/uTxetRUr9MxvUJRlh3RJt8Aef9PB4=;
 b=lWd/+lzgY3uKHLowd8srtP0SfcaAKauorbjIxK2Lr3fl9SXXw2MaKlABeTHcMCGu9i
 bVEHdSyVudtmI29a5vRKpvTDchMzM+QXxEuhUmp54YB/EziY1vjMxDQc5nOJuskfLap2
 Ho1ZGodrHrOtui+uwuVLILo7CPYxC7nJns/AQ6TceYMQEsAjKI4GoBLd1Glf9DlobDgA
 Cq1SlJ+PIst1yYV+h371ifPmVxsHiT5Kq7Y3hNcrye07q3GSfeEnyQDH4k+qgLawsmwL
 lzNBYNcSCrIszgs0Ojqb6YuX9gKeT2S6r/EM2fmf3dYvcNQNVbwO+xIozgfgcBQ0WNzi
 3aCA==
X-Gm-Message-State: AFq9FYLgd9L4cHPLrWWgFNhFEpOqWOIqAgnZXOYdSQnNohQbU/e2NYaQ
 YjwFpleu+BVbfZ3tgnsaSg4JKF3snOOxaCpeOekUZs35AdVrJKksZwmE5H4csw==
X-Gm-Gg: AYBFou2t6qioQQWHn1myqQWyWWYfAKUAQ8ePIzyMD7RPs4CKsKLS0ikVnTnWc3Y9y5J
 0r3y+m5OQjI105cumpDvWbcc4rQHulZZagB3OVkbgPeVcbkMH2bLIcCSJXwelE9dDpAYrkUPxBJ
 S4zmm2EaOLwTAayOBeXr6BFXPvZ0rOnqbn1lphZibXFkVXJUmeB+/XPSGn8K5Rs0nU8gbdpRClH
 YfpGnpVXYP/Uj1N1fiJV+OTr60GSfBvT25CT0RC3MEZ3hgcAOfT5N8TiPSoPjuzN97yBqHLFgEN
 1WaXlSxeBDV1qXsw0ofDc48JDLJsShI/CeVoITrnRUkg4jzZeEyk29FFgDwBAt3P8RMwm9emwn3
 L1SXx5KfXLDHQ3FFgFgQI5bghJCldr0BEDTx0wSOtNtZe8NFn5ekBlm9BAd0GOfV9lJk3ph7X7g
 n/kM+hqs+X9L+v8vWhsiCvsT9twwfm51BmZfg8klhjGIvOFyD3gVWR9TOZZHAPlVbPT90P09oO5
 Sl0i4D35byIx70J+2i4y50CrbdfQxeRN3KW+dach8ziwyqwZCrjyskOe1N022no2tYVNCaNpp0S
 ln4Yb8eY+XsWAf8Zao9HyR+fOYSU3JTE5bnuGwyBhj8/CKDT4CXutHGRcTFdVoUta9g+ZvV5dok
 1KA==
X-Received: by 2002:a2e:a98d:0:b0:3a9:7e4d:7fc5 with SMTP id
 38308e7fff4ca-3ac9cf49984mr15708671fa.18.1793295289466; 
 Thu, 29 Oct 2026 10:34:49 -0700 (PDT)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi.
 [2001:99a:a58:9b00:9119:221d:45f0:de83])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acb5d264ccsm32531fa.21.2026.10.29.10.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:34:48 -0700 (PDT)
From: "Maxin B. John" <maxin.john@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH 1/2] configs: sandbox: Enable binop command
Date: Thu, 29 Oct 2026 19:34:38 +0200
Message-ID: <20261029173443.1495866-2-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029173443.1495866-1-maxin.john@gmail.com>
References: <20261029173443.1495866-1-maxin.john@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 17:41:58 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Turn on CMD_BINOP for sandbox and sandbox64 so the binop tests are
built and run in CI on both 32-bit and 64-bit builds.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
 configs/sandbox64_defconfig | 1 +
 configs/sandbox_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index f861d3ef06db..c4ad63ce63be 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -43,6 +43,7 @@ CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_NVEDIT_INFO=y
 CONFIG_CMD_NVEDIT_LOAD=y
 CONFIG_CMD_NVEDIT_SELECT=y
+CONFIG_CMD_BINOP=y
 CONFIG_LOOPW=y
 CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MX_CYCLIC=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a3fa52460827..c63a4df8befa 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -74,6 +74,7 @@ CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_NVEDIT_INFO=y
 CONFIG_CMD_NVEDIT_LOAD=y
 CONFIG_CMD_NVEDIT_SELECT=y
+CONFIG_CMD_BINOP=y
 CONFIG_LOOPW=y
 CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEM_SEARCH=y
-- 
2.47.3

