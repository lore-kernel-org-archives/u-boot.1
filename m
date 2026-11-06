Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554EE606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0tV3JXge;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=E9QUuVLS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00AB180DC9;
	Fri,  6 Nov 2026 18:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vKzj70meja5T; Fri,  6 Nov 2026 18:23:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BFA881495
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989390;
	b=DWn3+aJ7CEJJj1sLkwpSsfozFXS97v/C3j9ay9ZlurP/FDj1TS3bR0zrlqhznJYSkeY5
	 MMCT5LLTdNPYJLK0YqgIjwgB930wB7+pRCVgPtGFsVdI9AH8PXuHzl7OVWZPicZcBaKDQ
	 VEt87x5Ey08NlHeOqHCjgrzEgGe1ZZht69X8jdthGbc3epcO+ONx5tm6eoz5ruJrGtZGi
	 N6PmtEOBO6cZ+PiFoFCkryw8hMtlc6s3lxUIffG6XuY9eqxPK/DVcLPw7sRreCugXdtFQ
	 YbSfBNOoelaL+AkhKbOziuFMoKQpI/Adob4SzuZZphH2AMs5qPtaHHJbXe2HBihWmkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989390;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T7OoB0GiDY8f3v5eHSXlYg9mJYIYjeVXp7OD1QEcYPw=;
	b=IiWdmo8aYV1fbms32vEiw9e1DINNsUfLco6TMR342zti/Qb1saVDnmHNBRXqU4YQmPav
	 uLfycSx82Qu6QA9Qe+DG3mansnYJTUdjWl+ar900Xpk5pCMw08myTsVUvSEPPNpRcTPaX
	 y9oxkYqKeShAGHTL9WhtWWPPTldxd+tNFhM4Cb7ipMAuVXE4phmM6H5dhw5BD55JZnOsK
	 33XyGv0NeP4TMExnahIuhORbhn4DCF7aGNfWz5FSD5ZmY5aV9Ei7azaFuGzruQTBqmJJZ
	 exJUNJLQA9FmwfiWi44dJq+7pMylkaKq9SZ7FCIZzhAB+3Vxw14ZPK+vT4wKySPIoSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=t0.technology;
	dkim=pass header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=E9QUuVLS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989390;
	bh=T7OoB0GiDY8f3v5eHSXlYg9mJYIYjeVXp7OD1QEcYPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0tV3JXgeX3VLgJmyKLg+hHJhK5b5b/haVg9sWU/4zg9uj3406o4to1OEqU0+qqSfU
	 NfN21kW30W+HsigzkXJGpi+4G2UqRkA48Yt1E0fkb/t7nm7iJs7AhWIISERdWIeRKu
	 GiHT4jP+0ADrNV1hxWbcyKAti05CeWnO6AC0izudbjimgB+vDpWKaQ9s8YIwhQ90bC
	 GlqPoWLIeeR49jX0QkNu99WNxVQmk6HxV/yUrDZ+K4WtvdF3S20ZgYkemlp2K3odZF
	 ra/4ntramefXZPRz81I9LUzCeirDxehtRSDR+2usm/2GgyjJ8T8YbKyCOmmhK2Mbc/
	 9OLLmi/DryIAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BFA881495;
	Fri,  6 Nov 2026 18:23:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8605534D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 782118126C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 352dyfdK5pbZ for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CEDA981248
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=E9QUuVLS
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CEDA981248
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:15 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8a052aff9e9so684630b3a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793985015; x=1794589815;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T7OoB0GiDY8f3v5eHSXlYg9mJYIYjeVXp7OD1QEcYPw=;
 b=E9QUuVLSTRQyOubnt4++vsjGvOySb7iZtQvyVehK80pyNgEm2kuHKlqbedAV0oP+ee
 PK4IZuVKbQwYyhfVrrHovm2/E6gc0wbuQx0or7X3Bq5tUtHZ3Kp9Uv+kmM+MCqdXw9KG
 tIfhUbLTLDKypCIMb1G9JaC3QGVghBUwRuo80hYg4FveprXKLrJIerGODqTdCflpgzqH
 27fBKZ9ZxqemHWKqAZTVdNaLb6+UDQvZa54a8l1c4PZwZIoS+buhMIsF2fJLXfwPJrrI
 +ay1o6WG4jmvyHR4RLU7cJOVh29BdZCwd55Wljww1wx8uLcDh7diag+srMAHYww3lMNZ
 kmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793985015; x=1794589815;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T7OoB0GiDY8f3v5eHSXlYg9mJYIYjeVXp7OD1QEcYPw=;
 b=zMJvT9yg3EOycTAbQ3rDfAdpy1bX1SNTW0BE+BktR6XlqkQm16gcy/NAbq0Dq+KbOf
 mJXy3O2M9nhSaHgJ4Ze8fI90pJbrKPJPd991Xpc5RpZTsZvUw5zyaW0ur/mPYLLb7pVW
 5rvqbMsYWmnnsQ+C0tZVli/HpSrp9lfseevIDj//KTNqi9QcF0nxL8GDUDa3AmNhBHZy
 onrcvANu7cVX8wJzUuFCAaMez/i7e+lLo0A6lYS11rW3ETO+ioW8fnW8qFbrncQLYjPI
 tjHrluggDNElOZYmIsvo9kVHPozm60xdETMsMcKqBb0sI5rlT5rsXiCUKrgqKnXCPtAP
 eCXQ==
X-Gm-Message-State: APuU4Z/SPbUB8WcIwIoAx1JvN+SN33kgutFlzLLgnlc3Kx+Ky6fvu7Ml
 rJR2INDBi/w4Lm3RlVLGxFtqDU79t4k+EFaKxtKqXIfAiKLwJgmfUuUVpg4YrB9fZTg=
X-Gm-Gg: AYBFou3o8Psmgjr944k0YTpmsUVaGVhKpne/scY7GbDLk6UJbMLHq4tVBIFbeTNdvgQ
 G/5vEUwnB+ZkrQhhRwLo5PotQbGbDbsbXRxZShuCtIqIE3g0AmSJTNVQZqfnduWMJUzmDgwGj9C
 36+odSG1nqlHK+wTcPagiAbB/N71YyXGxlPr76guj9TUCs1J7qS0PYVqWeNVeUSRNxvwL+rlh2J
 1JrCi7j4c2+rNijs1oAyufeG3aHPHpThnibGIdY4QMiRr1rxqZVO+MqWuNbWeschkifiU9gU9si
 Ueo3c7VdmrCoPEWiBPfZcsOkAxiAw0MRnPk1fqslyLGn4KWh7+NsQBEvsuA0zfWeAAhRGJoY6LO
 MW++eWr9yxdH8NrEJVVB62RelJjc7MScumNuAIHNoO6w13Oc0sCAhSqE7dvHfnpNPnxrj57XQFF
 lNPGosxnwcc95L9ZmA5RvATBqovbwiNMYkVv/IE7fGnQMk3uKhBWkl07PYtRedIcM1UrBk+dUz9
 /Awr9SYvJO2WuXM3+TBn0smYbObyxFwNjX72zAulc3WM307bJo3ggzTUiwx3x/W9dU2LIntQsIe
 wZBJ4LmHOAYDoijMe9KHp9HBI7o9YM54snyrQ2SXHs8m/lpX2GIxjMJVyMyf6YGcEhxQ3ovFumo
 SV34kT/TKbApo8KBlp09Fyw==
X-Received: by 2002:a05:6300:398:b0:3e2:b905:12c2 with SMTP id
 adf61e73a8af0-3ebb2b838a1mr3242715637.73.1793985015053; 
 Fri, 06 Nov 2026 09:10:15 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b359dd36d3sm767461b3a.37.2026.11.06.09.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:10:14 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Date: Fri, 06 Nov 2026 10:09:07 -0700
Subject: [PATCH v4 4/4] net: zynq_gem: release the SGMII serdes PHY in .remove
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-zynq-gem-remove-leak-v4-4-1995c70f540f@t0.technology>
References: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
In-Reply-To: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, James Hilliard <james.hilliard1@gmail.com>, 
 Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793984944; l=888;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=oumJbtJ+FYqt/iIlpfOgRbb+QN5H1ZBi5t56Bjy3u6U=;
 b=O5X+o7elp91Dmn9FcXr1IEpHpriqcUmPBSyykwZDSCWO8ePxzVi5Dknp4PhpNKuvdWpttOmY6
 NzYrwOwyVXxDdBeW9ONJvFkxTMy17wvEp8xINbXhsX/H/ZG/AEyvuNu
X-Developer-Key: i=gsmecher@t0.technology; a=ed25519;
 pk=HArD3wunb+MyhiMSP+Hd9fErsJgMgfaKpINxIisnHbk=
X-Mailman-Approved-At: Fri, 06 Nov 2026 18:22:59 +0000
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

zynq_gem_probe() initialises and powers on the generic PHY used for
SGMII, but zynq_gem_remove() never powers it off or exits it, leaving
its init and power-on counts elevated across a remove/probe cycle.

Power it off and exit it in remove(). Both are no-ops when no generic
PHY was obtained.

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
---
 drivers/net/zynq_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index ddc83de1c1beab31d52a17f2d41f608fd92ed8e0..f7f5a995938d7da8ffb507e64c634caa35faf436 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -1077,6 +1077,9 @@ static int zynq_gem_remove(struct udevice *dev)
 	free(priv->tx_bd);
 	free(priv->rxbuffers);
 
+	generic_phy_power_off(&priv->serdes);
+	generic_phy_exit(&priv->serdes);
+
 	return 0;
 }
 

-- 
2.47.3

