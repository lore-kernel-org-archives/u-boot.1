Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517C606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UxiPIyr2;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NWkNdHwD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 952D8810F0;
	Tue, 20 Oct 2026 10:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0cGuWnNw7-ul; Tue, 20 Oct 2026 10:34:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD87B810EA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792492453;
	b=QiNPMr229pA9q7D5rEv6QVshZXcSghPgeClg2rTDK4s5Kt2su2f4OLZeWkWuGZ/lk5bO
	 +lWYF9j7iDKPxzRqfiQR5RpBWHruAz2+jRN4sByezF/8SZsG1B5iWJmn9sA+29KXgH6HL
	 ap9LGSXH9CfRAzhgvi/fGRX2r/rXFT3CdI+ny5Cv7Z+xmUvbXJHseEWrMgzchbIrqoV7R
	 aOj2mPaVxlhehotXmqeQdb6uR+eCrJl/Q6ng6PM+n7vwRZDeHGvnccOb77RdhHZVOc9eO
	 rtexH/whPQ9f+xN2uEkq0kWmaMMcgM2ZRR+ukFwp+852vjCP+oFkmhvvW34ddwhiIvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792492453;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pCurfqQTCGpKiZ0+QMM3XY8SQSB23zeINELWluoNBmU=;
	b=PHXMXA4iZRnrONvCz4E7dfa3qp9GPcwyba22umanDZcGMZ0gBV1XxJYfKT0YXTDQwdzC
	 FfZ4mX8KQ9Va1srgoYFqskQfPNeBRxtStZrru5FIjcgAcMdMKcgdcP7Sz6ONuNx9RKQHO
	 O9MQn8247TRA06PLiy4TgWXbImfO7BoLmqa9oPyfjp7yxGUD3cEi0q9mEU5+MHdXuzraA
	 VZJHIqjY5r9rzC/fLy3xjmSw+D7bq/kiU9mBbKSywChMBrUlYuyTfQk2gQ38OeZCkmCJW
	 tz4Ql/X95KdaQLZ+CafFBDLgyTkTW6vaQWsjRN2DshPxASgzsrxGt2zD2vrVq0ikcww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792492453;
	bh=pCurfqQTCGpKiZ0+QMM3XY8SQSB23zeINELWluoNBmU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UxiPIyr2TFrdZdf8LExAQZykojbXedNSwabSrKD9dOeuBcXH6YltWZX+Moke14ga0
	 Qrt7mMKqnNvdr1opzLkd5NtL9Acg6ap5eplscigjJmPQ+K0rRXduZcL3/9WJtvkTbS
	 +zRAyVfjvCQtoZ2daVDVRLV0wNd3EzHpcTp2WzNEpVudWmwwqGlE0Q3ObZgSIykqhl
	 1zvRR13QG69AxlL2RmCy+8P5lle72lALpE4UElGLkrIrPKV9ND4Cnw3UM3vxkLrOZ1
	 JcyDEjU4S+be4IsLVEPBiTYgWDe+eC76/bF/0ausKF0pnGKZXuAX9fNmXNqxlFJW76
	 LjKGUNQG9gXCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD87B810EA;
	Tue, 20 Oct 2026 10:34:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 340721E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15410400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dPIV_PMA2q8C for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:34:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1FD4340328
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792492446;
 b=TxQe357k7PFrtR21+NuVO/tQvZWu7F+JBh8Ij89ys6+LfwnWd2A9YOnJs7w8uAaHamgg
 1cUrxbXFGyQYOCGIXFLRP1cFhwJeIzM7HgtgGh2trlZI3nkjdM/LEKZjG+vIKXP/q3TdP
 YTd+A3Abdt+JswKWPJkYvUjenChMXGmi1E+NKFCk4qN4tGM3TOIp9GvvDtjn90weYuA/x
 oBZbJffYbPwRv9PsSh9nP2WsQopjK7W6AuDFhnLU/Vg/LTP1cF5B6IrdYTnNp3L1H/5FW
 2lCrRPq1doITX5uFpZemNNe0rGMFDqJaAFZWIpezYGak2COdyuYMQ2c0JTu3URgcmkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792492446;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=pCurfqQTCGpKiZ0+QMM3XY8SQSB23zeINELWluoNBmU=;
 b=LGJWvhiyBizf3YVIOOApw8HphYd7MJV+z/EdDuYTj0QsqUTzv7HyiDFs5juvuc2dd+Ca
 OsYNRkwirncCG9T9+qZ2pqWjXedBVDZqAmFOPPvojf1ikTCyyfVrKiNIqPR3wW+JaMAQw
 xqCsTVmVfGC3XR13QPJKBMmyIqrWSjWWL7MJF4Kq4H7D4Lbv4ey0Ll23m7cHjzsllZHHk
 snTcRt4d4aAURzCyu1Z4qAAgGB2TCRnNjoviuvcRM2Cowi0Rnhzap+aRROz9oM3WC2Lyt
 06nMYxtgbHDtTYovJHDOaa2NSZ0xBxTRys05fMBxuhqpyEpEyiE9tspj5TBNO3v9S2A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NWkNdHwD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NWkNdHwD
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FD4340328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:03 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso3917285e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792492442; x=1793097242;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pCurfqQTCGpKiZ0+QMM3XY8SQSB23zeINELWluoNBmU=;
 b=NWkNdHwDBJ5IbrJTaEaYJYiuCHsjJpKsh1X98IOARDNkDL+4xDKaahcLlX9Xkogzqr
 DWPfHzqT6K+b8bwnO5bNasXOEAv38EQfVrQnAQRQGRjWVprkpA5LgFIbGaIfF5Zp6EGw
 cS8MH6XeD+QjvzDNdDMoFCw9DzCgd45Rwy53Dz+CksHrQmwNng47WXV5I29ozjU5grLM
 UCWVkQhACDy0HxP2YCgO9N0c/U4kgFK/fcCo/kjToOnsEpAnNXN5CReYH9K3bDBdFbye
 YNknyGh17UbCiqs54dG0v3iLW4MYM6M8PJraxhyvhhETizqmo+mqIAxej8PlfAIMq9vP
 94Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792492442; x=1793097242;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pCurfqQTCGpKiZ0+QMM3XY8SQSB23zeINELWluoNBmU=;
 b=ElVNiKn3FDULsmnPZKdn/D5Kar40pce9UD3HZSadLfcezV+JfnCL0zdXQVrZ0ixAI1
 JK5kyhhRA0lNW1zP4do1qZXP7bCVTLsoEZPZx67IX6rlvzKsz1UZtkstWgwjrN9CAd2A
 +WCTmJ9UKhc/ztvNGhZX5DGNt1a/t/BHq3eE/jqfIbrP3VBYY+X+TrUeL1SYWeM4SHKR
 /3wlUHxKOAdnBUNAFcwyPptmGMDCfHGRSnvl86tNBf4x3Tz8tg9AA9k98dJ4R0j2IRHq
 ao1aW/MJ9jJG6iXM3mE9VL4Jk91BE7PDIv7k3t6nczlcAVTpCJSnVBv+BDPqBL/W8Q9D
 9MUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByPwJh3l9Z9JYttAcggyD9lOy9/9CxwtdcjVXB3b3iXHV7W9JF/L0+cxRDmcw95eZJVx0ZXWk8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJK6IoYLA/I8AIGj9LUnE6eqT0NwpYH+9+a0ZMtSva78Vvuv4L7
 B3roXQLNoKN83Ji/0V/K8+gLvL7X31DYOJbbkgP9f/BD6r5mUd5zWPOqzshr6gRPk9dFjMIUbSl
 klVTv
X-Gm-Gg: AYBFou0aZNZRZedp1+fpxB0reJja6NeY4fxE2QkX+nc5cJOueJlZq+0+n60j8cC7Woq
 pudJaJVOMlGjucBr0vS8T2sqVBKv9W++b0U6XKo46RFKYNCa7b6DIHz2qOiSGOzl8Ln3RBsGvc1
 4Syieqew1Ky40SbrMdDwIsz1QcW8UKUFDo9XLHasv/ZxqcJkXxNi/aXI7aOHqzwXRu3lY3Q2yhm
 D0xXTYWadnLThTN3Z9X8vGOTXlRuTrOqkDUlHS+WwA1g5FuUv5UAUrGN+t6hgk7KPSdtn8L613y
 mDaMjTM6oVKgvyhU2ahc0MRbqAefV/f+2SmgiUzyWl9aqRGfdZuQ0R7RlJJvyONJJ6M9pG8spd7
 6FM9o+Bm/DbInxJJrbrKI1jL/84vcFfZXCHBcDVeH3n4WcD/ChQrMoc/gKAwwxLgV01G7EfcJ6c
 evkF5+uoz/FqYPCdgZxWbKF8xSLNbISQ5J1VwetwQbyXsPBIwwUV4GFoIsc7MlbbJ9DjaMVt+il
 JKAeLxRIJpNZ/8l0ykXsw==
X-Received: by 2002:a05:600c:3114:b0:4a1:ac66:604b with SMTP id
 5b1f17b1804b1-4a1f4c70117mr35782295e9.1.1792492441748; 
 Tue, 20 Oct 2026 03:34:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cdc342sm67880245e9.13.2026.10.20.03.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:34:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/5] cmd: avb: add lock/unlock commands
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-2-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
 <20261012-upstream-avb_lock_unlock_b4-v2-2-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:33:56 +0200
Message-Id: <179249243656.2829155.14725029974726476769.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792492440; l=605;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=iwJn3eFr1wBx3G/UbVMVd1/eDBfG29TP7ilMGIvpvN4=;
 b=Y9uHKX6jj/f0Wv5qCP4bxvoRemsNyFFy6kH0GAI5QgnWEHTGg0idiYn0kc60NEik7Oy3i2I8n
 O5FieqFF8qOB7QQxuGU2BDnQGiffI3q7uDKVUxAov8rvsEoLcAYaxvK
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 22:25:04 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> The OP-TEE AVB TA stores the device lock state
> (TA_AVB_CMD_READ/WRITE_LOCK_STATE) but U-Boot only ever read it, so a
> device backed by the TA could never leave the unlocked (orange) state from
> the bootloader. Add avb lock and avb unlock, which set the state through a
> new avb_write_lock_state() helper. As documented by the TA, changing the
> state resets all rollback indexes.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
