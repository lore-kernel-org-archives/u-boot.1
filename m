Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7980606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gs0lMrpO;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ApiA7Rbu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AD4081328;
	Thu, 22 Oct 2026 21:05:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zY0zuQalsC-N; Thu, 22 Oct 2026 21:05:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D79B812DB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792703154;
	b=L9iCfihEKr/4Yn/PbLK2sTB5Wy61mOyCWpHFgTsPCWhOEtyto54Zrv3nYB/YgeI8lvsW
	 j1Ji/ir8bLBR+kLO8wS+pHWeuZ+SWWsuCjcY/AZr6z3bmr7MMc7PbE61CA01K+HYRKv8Z
	 SEm2TqVPmvIIwrmdpWNSLIiH/mlggd6qC3q7SbUKnomvm+FWiw0jgMdbAJMKFdnwBVZzA
	 /RmXvzJCT6pXLq/GQwqkOdwAdJM2Rzs1y5rpvz5eTJg+EtFJxLMeG6M3jCUnKEDXUYUdj
	 zy3lFjGtUQeUU2FiRJ/FKhXl6mqZ5emwKHYdny2mtO0i06t23Q8ZVsP5IDBTtRo6PrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792703154;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=keHPaFgnWpN/z94AI7MDV19zqI+k0cTNjOPtCwgqcEM=;
	b=fNNn4IYscu+NA4J44msvAPJIoxaU2Ol5eWXl7hnW3wCKaAG2kpmBmZ4GZDVmYY2S6EZt
	 KvRauK/y7W3ndEAgA+lm6BoOPPBscP1K5mwE1YXkX/qLNnZx3Ns9RKkCa+veV5Snw7JzV
	 NL48R/KYQDSAZeOC2O61OifCflnVi2u/MvlPVtFhCc4lG32LW07UFrJWi5ESe2l9FPIxe
	 2NM6MGfS2f21wcR+OLCDRtmntUqcsB+wMTqtfGvOF5WUhDqxHeY4YLVeCRGMzUab/4pCG
	 vWl1hou+GwC9FOjm7WEpZUtMOhBteX5PQMBEnxI5IrdZANtw6FOYH4jweHSYDYpYsGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792703154;
	bh=keHPaFgnWpN/z94AI7MDV19zqI+k0cTNjOPtCwgqcEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gs0lMrpOeeBhYqpbEOuqA3zUaI0aogNvGFgiOBQw92pUnLpi1hLBr0ZINlB9jxEgF
	 n+0VGbccFF3QjBwVMnolbTYXQrz51Lm7xieoUSAJJXOW1bRjrEbCTs+bfEr3DSIYgo
	 /+tMiVm4IZ7pn1szvan1IcfFh6vaPYSllfwBUKS7Axfy9R8Gr6Q4qXU2mfhZYJWb8O
	 5kMDiMbvcp1UuVK1RPhMSawdcAacMk71NAAE7LKvhU0Yy1tbH9uLMw86XHWZ5K4dzL
	 FVrFGzPDg1Za4No6Y0faW9L+KuZxx8eiIR1+1+gbCkMJtH51sZLIx40YHYVCP3WmwY
	 Ic6f3XByII1kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D79B812DB;
	Thu, 22 Oct 2026 21:05:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B369499
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C78E6080C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:05:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IKmno2YSeJI7 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:05:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E906D606A5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792703150;
 b=om/2Js+acfQj0ePvTUJUnan1mMPGqJQ5X93QENh7cy9EqoalnpHEdFWN7X3acFTD5n9Z
 5bI7L/tEzRwozmE1HDcl6N84w32efs4A24ts79Rl5NQDDjBzEBbJWvd13yJvRZi84G6VZ
 d23lvB9BIUw60kUZLpUytPD2Ul3qInvaL2PZVxHbsPg8jU7G4QPJk6o4jO0XfFsidYNBg
 tBYhFjDUwXFFGYH8KKXPhtE9/yiCvahDYwlM39qovt6k2C9buw1UQXYdkNz81aRdtC6KI
 L/Suhxwgw9jF7SsTDraGlpFOWOibMJaBDW/rO3WlaaDjtjdzbCVpsbz5TH0Ifyd+sAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792703150;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=keHPaFgnWpN/z94AI7MDV19zqI+k0cTNjOPtCwgqcEM=;
 b=Mk1zIF8uRZx5adMF+B7EVp2/mCM1u5FRvKEp/j+4t3Gn49RJ1NgW7Ub9C0EnloVn0pLD
 kiQe5iXfS9B7qxqPmJlMTpPxk/4SXP3wca3+jxNkg86r+I9WT772D4sA2ObitLoDE2Rxy
 5pTWoXZ+EnI9d+vM10frhGwEZbPIHfF7svHYk0DghXjEdYSqkfASUewPdUftOCiMGi9//
 ImyRSZ1qbsoJ6ECUIQ3PF/2lwS5e41mTqzNDB/B/M0Nc7pXENinHnN5XTJAlpArrTi/g0
 tht7D0wTEHqhnRpg/W+mxU7oGhXJXzNvF5cn5JJL8ww4inmVYAJQYqG1cyUgMycJCTw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ApiA7Rbu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ApiA7Rbu
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E906D606A5
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:05:49 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4d7034a99a9so196278b6e.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792703148; x=1793307948;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=keHPaFgnWpN/z94AI7MDV19zqI+k0cTNjOPtCwgqcEM=;
 b=ApiA7RbuIAlC2bJKz7bBNA8eMmx3NSmUXq+oa7Jk3QfdVmO84ERYi+qxY/9XaMDQFu
 d+Tr8vEq6o3GOI2SZyPqZiYuyXwjkNC9zaQANMEwBGBovFwzP4UdJxv9EUYK8eaJ+lEV
 ThTD8HE/lvcGnbV5fJBHA/hArXBhCS5J3+Uy4n5tgWnly5D0NJtqOHsA6lK5WyH4B41i
 dJAv6Vxj7H/39n+uipya+/gQYS9gzJy+uZpfCUunMv3oO6CuruSAua7qnDU0qUjEB2U0
 U5uLH38o1iKGepTTUA+7jOVRtIDwPQuRUxL7/WzTB1VH7g7iF1ZD1QL9cTzaFteG9tnm
 Dyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792703148; x=1793307948;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=keHPaFgnWpN/z94AI7MDV19zqI+k0cTNjOPtCwgqcEM=;
 b=roTn/QmyrL3+lhvWmN+6tJnLEE65Dbe4/32AYqCr+ivesA1wB+GVxMaF770s1FgL6F
 7CT/KnMOUrb0vkybtt5LcwwXsNCn1sV2VRQ2HxVUhrkjFFOVOkXTlZ6KcLzjz788bIEC
 lLwA6XE0rXVjS8cnyMlu7Ys4NNq5fsWYjfs38MrJlFu2MVBB9sggTXie3iBkQVCM8PDv
 hwFSxAE6QNlXxa5J0OUXrobFxSCkiMSMWlk3HT8YQAJnl3Lmbb0/lJ/4JhCO0h/oj4+E
 RiSBw967oZ2Q8eXGKFfZewbrWNWD4/VReeN1+DwOq54jtz9T69PVgxc34l2bYThvnPIL
 whpw==
X-Gm-Message-State: AFq9FYKZyeCUZwzDmdZeUk+bXx7j5NgY0HGBxJlyb3Q1v47b+szMDAvk
 UCAkytBaxHQ8I84CCsX6Pet6hpPlv1ZiB2e9Iy5of+Z0tbPqP/PJHPvQI63Q+kVBzI0=
X-Gm-Gg: AYBFou2TRd/Kt23y/QOpVd/dvrl7R946xT0pUjjEeW0hIBwLy7b+lio/12k93qZdqjU
 tZZYxmnk5YpEH6wuTU+46bRZaaWvhIo24+uKQFzhSq83PLQztWltkQ/oENVFdNCC1zEjGsnF/mt
 B/cVw3jaiUxpVk2+2AsWnsS2CTdHQd/mGf30umqhKXu7yIVHk8epu2iKa3qRrqM1xjeHRoD/NUl
 66HVPfIrwa7qhCLIKBBLCR3qza9NML1zBQWW4Yesh63ioWqAJ1pfezQwjVF1Nf7scD8MxlcyIH1
 y/CXCV1e7JurhaTM9if0shzG7zNvoH95jVofb/d7ZrE6Ma0xzuuIWWcVkhJJVYTgeFKwQqhbG2Y
 CQgq2dy49AHPFavj41cBXp6KfqOUC8Gmg2muWqRoIvONbrTpeZHmsfRPsciFBZ93o7b0IX3Jwug
 p44/4tvGg0yxBOOSP7OLcBU4qCXB5G4Lvp/Q+MLJM2yHweVRU2gEOZboYQRngt2zJyI3DuBRkh3
 Pcq9ahzZHrj3bGh7LPbfjsRzWJvxpAWDppaQm2YxmYiMFLXR3EivycA3QfVTw==
X-Received: by 2002:a05:6808:c1b2:b0:4f4:b62c:a3d8 with SMTP id
 5614622812f47-55be84ec35emr193176b6e.33.1792703148483; 
 Thu, 22 Oct 2026 14:05:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55be97a0f1esm57465b6e.4.2026.10.22.14.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:05:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
References: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
Subject: Re: [PATCH v8 00/12] mediatek: add HDMI pipeline support for
 MT8188 based boards
Message-Id: <179270313404.3711947.14306286882952541994.b4-ty@b4>
Date: Thu, 22 Oct 2026 16:05:34 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=965KsgIRbPwZelFkuohtJrUnWD0QJUFzESaycR94n8k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2nqgCZnMvxm6mfNNJ8jDGh6iwZG94+n+iEt0d
 AgPsJM2HKqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatp6oBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ak4kH/ji/sm5yelhy3lRXuwmkuwRQCYYq+z/zYwsStmn
 17HnWVMxG+rzcv5uClzM61NfmLanZgpPlpV9F6GYLHShmT13hEjxikKcvOoxPYtCOX1+7YgXt5Z
 vngsWhWTq0XexMfKeYpg02PUqR4T1GxkgJB53hq1dcTtFFeXdeaQ+LJxkP4ia8NmMG01XHJkOcu
 avRR1NjU9hIOzyOKKs0uDS1yMLwM4d2bV+2EQBLJzRVLVYnyZBQzhUOsPzLmrg4ftjejspOVgpZ
 t/wrEBc83641xQZumQpAV/4wXSFS5zk8MYdRKTizC2nhzU4VPim9bYVetTy6xldjQfjsEqQCpET
 RrV8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 02 Oct 2026 15:25:34 +0200, Julien Stephan wrote:
> mediatek: add HDMI pipeline support for MT8188 based boards
> 
> This series adds HDMI support for MT8188 based boards, such as the Genio
> 510 and Genio 700 EVKs, in order to display a boot logo over HDMI. It
> builds on top of the HDMI PHY driver [1], the DDC (I2C) driver [2], the
> clock series [3] and a clock fix [4] already sent earlier.
> 
> [...]

Applied to mediatek-for-main, thanks!

[01/12] memory: sort the Makefile alphabetically
        commit: 5fd68a4100e60551dffdf08ba639f431d057bc3e
[02/12] memory: mediatek: add SMI larb driver
        commit: ed242b1b97df91d1a1eef476d782a10ae8d7e4eb
[03/12] video: mediatek: add display pipeline component helpers
        commit: 9d4cb1a32db890945452038737b56b55a445dd1f
[04/12] video: mediatek: add ethdr component
        commit: 53658988ea77f894ac92a90a89ccf698d9e41663
[05/12] video: mediatek: add merge component
        commit: 429aad8d80d0ddd2998057c2f98e0c3513cb01fc
[06/12] video: mediatek: add mutex component
        commit: 07ac492f6563abbc98a2db3d61c3dc17a2d5b354
[07/12] video: mediatek: add padding component
        commit: 3d5c58c3d9405f24563212980efa70079768dcdb
[08/12] video: mediatek: add mdp rdma component
        commit: faa8a32143306c5eb2f3da5d79a6341cd564b85f
[09/12] video: mediatek: add dpi1 component
        commit: 8531c3648904e9a9151635952d570b4e46be3dbc
[10/12] asm-generic: unaligned: add get_unaligned_le24()
        commit: 690fbabbbc8de8a86ab5e41d36fba2431bea5ddd
[11/12] video: mediatek: add hdmi driver
        commit: 7911e0d2f2d7cab4b6fc942c6633fe15983a0f67
[12/12] configs: mediatek: mt8188: enable hdmi pipeline
        commit: 5ce47efe819e2d57dad39f0e4f95881c33be0a51

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

