Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7E606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lvng5oth;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MZ9X7P8R
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1388A6080F;
	Mon, 16 Nov 2026 20:14:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NWfYYSoCE3F9; Mon, 16 Nov 2026 20:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6110560774
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794860076;
	b=cI+0JtTBlw9hLe1+kmBC6uebzHqwfhhJN3BDPWN3LTBF2gqAxjFOmIDWtwLDS7ri+s5Y
	 CilgkftUpeL4JGG+1fcy1H087LYd8w4Xa5h23M7K2Ex61c9BL5cExCXZtX3D1pucYQyK4
	 4CfHVHUsu3BlYjXaIISj3VQMsRgkQemFFkK2RHNU6chuI+FW96fqXMiA6L4LzLKrCYRRz
	 ixaM93r6lNk6fpSv5WJPUIlyQ4vkm4qGaWfayNRV8yzPc9agxJeTSsTW0Cuf23SAPGSoo
	 GhK3nosl74/3vb1Ed2UtO1NyA6sKJWrGZcoFJg7P2WHmrRzLme/I2B5rIVZvdJ46MeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794860076;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=z2Nizatl0jfjuxSubBExZBZz6ZDXS6f4qLf8fW2Uzc4=;
	b=p8qppWKZcm/8NVPasJYKzilxjNgS2Z1SZhmJLPLv34JSyPJHceoBWxK7qjIricenCGVc
	 64FVxce8/eAejjWwTMBZ2SAE6HVQvu4t2WxrjLFj6f/O93MPblLM5t05Zefl5z2T9gcRb
	 vV8pKzSoYy+kRHVksxLcM7JgNzKASe5DbuRZedcABpL9SY6a7/egH47aGGTzNZ0zovnys
	 2vuCgiUf+LPZY1yDl8zr19NMofMgDiqjoMa4Gt4NYqMiNlHcw/EnvbcAm6q1MNQRLxVYj
	 UAQFYVTntGJU4m14W88Xbzl2v4V13bLonqVU3N1t89IMiLXR8aZVS0EQJur6vwEepUQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794860076;
	bh=z2Nizatl0jfjuxSubBExZBZz6ZDXS6f4qLf8fW2Uzc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lvng5othnxaayvO8MZQsNJY+Sdws88bCOhEBkllpUMzegt1aeZvykNdXVTO2m14D3
	 UA17sPeQUdX9DQGZb0tGBpU8zhGNmcNylve0Xx5s5zjtjRA5NdVgorGbtBn2hV+Lp9
	 /0LELj9znXqq+SI4mrasj+6PWOdiLPqcFItsN++8nSg4YiVGdaKe6qEappBBiiNC9Q
	 kD5j8tM3PYVMh08MSnv36p1YhIdKZcp88LMg0yH00VveO4nzqGQGqnO1RIOeNRqsLI
	 MjDKsoLof7+jBPvyMM7q6s+Riy3r/IGrDEVQsNzLwB8wTPPmBYRXksB8E7jtfUkqJL
	 TLMlVQ7FWsXjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6110560774;
	Mon, 16 Nov 2026 20:14:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B175D109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3873405A2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pa5V5lCLdtwY for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:14:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0675540588
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=MZ9X7P8R
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0675540588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:14:33 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-8451a619da7so3245070a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794860072; x=1795464872;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z2Nizatl0jfjuxSubBExZBZz6ZDXS6f4qLf8fW2Uzc4=;
 b=MZ9X7P8RPxQAl5uSngM0hX2iEwXYunGH9QbPKMbHaoudZs8Bg08RrUlbx5HsnHKMMS
 IcVvXeDeaiVS60fr4pLivWmH9KiY45El7VXDXCfJyXkBq9v9i6+3lCGCfFe/TICxfcnT
 8MV+wB9Otb+KOzlmNc65MlUemk90HD0QB+Fvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794860072; x=1795464872;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z2Nizatl0jfjuxSubBExZBZz6ZDXS6f4qLf8fW2Uzc4=;
 b=fn4XAs24wDqOswo2QMVg+cfnvh0KDUJIcfECVoytEozkGK+NYd1ozLfNSx4G3fyShu
 LBDWo2CyeEvQiS/pzotE4Vn9X/xI1zN6au/z+iXItNGthieJA8iZVACD+5uKzdN1uaZD
 1wdZJgZ09xuvjZuGgQQGpiEi9vxQiNpNkfCgOXLAJYgY7RN9xkoaRh/znm4ckkfwsJT4
 z5hfrjqNelR8NT/qlXtrLDsQptm01II77RCyS1Jjdl58mYPnMyD85300EYMjG4RihKvQ
 GcRTRCDXWSoRMJtbbM9bTR9q+1gBwSiF6dxn8eLJSd8qF+JGMVOcjuyNKCPTcSaTucKn
 zwdw==
X-Gm-Message-State: APuU4Z/14qm3CaggyiWTBkVc/ppXFUHDjaDKbIHvjocURKb6QSnp9GVt
 KMR271cQf/BFp8lR5s10txE8z3St6CQk3ZInlg19zJKzxd0gEBdNBwBgNgE9lxQgDlY=
X-Gm-Gg: AYBFou2jeSJI+lopKZ3BuNGZ7nPUWpIP8uSQi08IehhUvJXhT7AskM+u9o71FxCVZZ5
 1dhHB7HToRZsw/6DlASbaSX9k/N945Z8b15J3NPGrUy5RONp2ut1ZXqeI7cbtWYnPAxzdu3rt5l
 61EnXbjRJSZdBNcJuL+T2E+p+TluP1C2EaYNcczGysh8/9zJPvpIH5E9mLw2CtZT7NW+BVpVNFW
 J5kGrSaGPZrN+vWU8npULxF7Q9xixaJ5cNTYEYUAc6O6uXQPx5kmrvM+6ti3wd5omI14NlxhD9C
 lwx1Sed8jMstIy2w84Rqabl67r2zj/4RnaOYzESKr2lNPoF6L1giRz5KMvxoLEP01SA37wWECq1
 BdNsxJmUJF4Ejd2jtoW52rgRbM4M9gS0G6jEHxCxXCNFv1nhw6Af/Sbff9YLdCx1sjRAHg2mykR
 ALyTWsilGc94zrwq3jkPrIwC3Z5273KHxtBY3yutIiSfWVhqk9c471OQd4yAyioZCDBlAY+GYRY
 qbc/IGlx+hguzYHD1BKeDiDGANczGFWozWNoo5iw7g1ZP9pVAbtarXH9WNdAu6dVjcOBmuAyKNZ
 yHlIbhD939p4RBfQ5qeKuSCpWK8vkc7Cgj0Jt+Hz+bv9Zbnu0g+t7hM4CETAVtJAh1CjekryHqG
 h3J/DaluRAV1gFIgvdEz5NcQKYTTm156yIqDcnkFNfvhkEtOJQLpCWhpVqNlbJS5ZmDASHkJRMu
 Mo+WoFtp5zlyJLdusJ1KoJjc9zUQ+flg==
X-Received: by 2002:a05:6808:e88:b0:564:3fe1:2f95 with SMTP id
 5614622812f47-56e66063859mr9413919b6e.56.1794860072695; 
 Mon, 16 Nov 2026 12:14:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5750329397bsm2061768b6e.6.2026.11.16.12.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:14:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20261029062735.898715-1-marek.vasut+renesas@mailbox.org>
References: <20261029062735.898715-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3 1/2] tools: mkimage: Simplify fit_pre_load_data()
 data types
Message-Id: <179486007150.2550799.3503326187291501595.b4-ty@konsulko.com>
Date: Mon, 16 Nov 2026 14:14:31 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 29 Oct 2026 07:27:27 +0100, Marek Vasut wrote:

> The fdt_getprop() already returns strings, use const char *
> and get rid of the void types and multiple type casts. No
> functional change.
> 
> 

Applied to u-boot/main, thanks!

[1/2] tools: mkimage: Simplify fit_pre_load_data() data types
      commit: 4717c012abb3857c2ab2e5a198517bc2133a0853
[2/2] tools: mkimage: Fix discarded const qualifier warning
      commit: e139a77788b658b02e1dd52275bed23481c6e317
-- 
Tom


