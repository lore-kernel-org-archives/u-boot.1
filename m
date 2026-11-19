Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6050606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l6IruTBK;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=g9a05Aak
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99EC78149C;
	Thu, 19 Nov 2026 18:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bCAmKlELadxv; Thu, 19 Nov 2026 18:11:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E18BB814A1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795111866;
	b=HtfvX8FoGd9VoA/OqN0Gj49tFzIgcpB8+jAEKJbi4HFGrvHsGz2hAkxRIu9QGz5kX4DO
	 BkrA6QShvMkp6FGJI5GP2znNTYQAOEn3xaPa6ZEojhHct5WU8qocpw97Ag+6mEoJ3tjA3
	 gMF6xBRZLXAnLwGxKIpA0ro7fBFQLh/emsMzsBHFcOIuyHMgVgZh+6aj9YvuDM0X2I7GE
	 8xrWnjKdBoMHwlfhdrgxjciTpFdr6fYgmPPAccU4yKbi3ruO4xyIC2LuhHl/mo4G4fl+B
	 AFne5chHytlmp0B2IXkio7+krXgNXGisxwwpJc2gXdCHKrrZLNKD4TSyb3ZHxIU+TTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795111866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Lo4Zyv9WTLNp4rNKSylNExrq5AarmTW5O0nsD5XyIoo=;
	b=ay9COvyJ+UucIifFf4JnRY1kRK3+pWYmQYAk5E8tf5DnDLF3sKE90zAogxYKZZu4nFxw
	 46XLE/KiWz7UfrfA+eXgmKvM/ju7a4Mw4vgGr9gkq2imLMog7eTU/VVma64Yo8CBeEwfA
	 ktg7MB5Fjzkjc2EsncpyAd6lHotaP8riTtBRhe7hxfRcmb3kr3TIkHl3L2ZSGEe/10Lv9
	 4vkQ38EMxHDNgoBTgsXdf3kxrfquMypmrGZ9DwCmG/pOU0CRf4/wqmNy2VbFrhHzupH4W
	 88Fa6CxwkxHIzYOWdKS11JVpd08ITLsALroTcHST7ukjMszUTmt/yXvy5yyCVwKUOBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795111866;
	bh=Lo4Zyv9WTLNp4rNKSylNExrq5AarmTW5O0nsD5XyIoo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l6IruTBKWpYp2ZJncAl6g3f9e/Rg0wKlCV+2fgHsfYP5IPsTMYVVjViaYvUXhXQNs
	 mTYx49y9C5TzvjyT8mu14ICyi2LZyMBRaRal/4qiCqboaCIVMfJx07DjvgFHqhK80H
	 0KcJwYs8O7P3hlHHhFH9feoSacWLSnMaDcF7FaVTd0jgrzGg5cvlaosAsPfsycLAid
	 HQXkq0Z8tLQWkgBCt/FzcYC6LLr874/A0WviESrNU2yOl5ee+5TI7jugWg4RyXjQyF
	 N9nlFnWgBOOUaUwXU4UVXWGgh4wuk56aS/egg4BdeHrPU23xjz9WQPs+I/YcN1pcXA
	 o5CY5VcQa+6tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E18BB814A1;
	Thu, 19 Nov 2026 18:11:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B86C465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3889140AD7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RvbuU9Ff15yS for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 18:10:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 686FF40AAB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=g9a05Aak
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 686FF40AAB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:10:59 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-8470d7d430fso31425a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795111858; x=1795716658;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lo4Zyv9WTLNp4rNKSylNExrq5AarmTW5O0nsD5XyIoo=;
 b=g9a05AakUDGrCfim+vbH+1MTYK1vZQGh8tijDprpIB8FMYMcKzvYGmZw2IDMb1dQCx
 Ryr+khHuuAUs83zA3VEd0E61qLBkfAMsmiaXCZ2g+t7Cc1gL5EH76JBt676JQXrx+A3o
 tT2YBcnSsSu3kTcrCGpeNIealnk9Iu/55T4lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795111858; x=1795716658;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lo4Zyv9WTLNp4rNKSylNExrq5AarmTW5O0nsD5XyIoo=;
 b=sbh4kY245wnwbA9IuKJ+k4IMjtgGdsjj6b++sv0bR1xi1l3YtRpupEyUP+qtB59MQ8
 N3Os+l0kU5YniUGvl9h2L8rL0++U8pxu7oLN3J7mev7W+ESp5WnUt7a7Iu6BTYo4ykrO
 2rz7+xC4x8IL89D4RLu881PiSiJ15PeQlzjYdNYX0HGhG8eD8Cj1Gja+ZNA94IrjL4zA
 t4OH7ujyLH6cw0Jc5yFEU8IMaVYhRy7jH7ip+XB/Qv4RE/btWHtK5UP/I1IM6ZM0tjVJ
 hWmS2tjL7jyimp8W2dg/cJ9UU6eYpThZR1LphFLyZwbY9C9VvjBJPYpGPRsarr5/Run7
 2GFg==
X-Forwarded-Encrypted: i=1;
 AL+hErGpgFKAMI+rIPEAgey5WLQGBa15J+Ak16Wpkgiyww3Cd6DgIoJXhltMov8p/QWPdAvpMYf0Ofs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/NK47sUXpuDyR3TU9yOCGpXY1I4ejM3XG/N7alBd1ciBwuU+QF
 WcEZBUo2h5k03NBkG3zYze3HNyyad9QG84zyMnKNdFhGraHwRCnxX7aS3WPWMZKYAdMObC1jqaR
 fWd0BSuCDnQ==
X-Gm-Gg: AYBFou2ax5KNZYRuCw2Ta6uDy3uUexGYVy9WleJ0dh7ZQcepNxnDoozj9KjvcrtaSdz
 deQNATdAiKZUaDvRBVCxd4a6tRaj2NuBFc56KpnL/W/2Yu3IuyCgGyUDNLEKwq7ADiFkctvBx8h
 rT9CXeiWdSqpUm6nuFzKnnRCsOuIbkCgkPC4fYJIakRdQH6gM7Z7l/mf/FSZG8y/s0UJVofZW0J
 sVExJrL3/YLxOL4JfknvztXT77F1zeI1yDWn58heC2icQZ2K3YptDkGziApD7Uep3d3wJrYsrud
 opyfSe0B2rkE4PXn6QrTu56i8Vt+bYqO8Pu8bWaqRHYFVtlS61AgZ1rtyaCsQV9g3a6EZQqyLQc
 bxTZcFX8dbBxF5o1dd41Kfu/Rr/oS41lAS9Bri99Gr56rWlcqXJq6/03eA1TDRwXttvZ4qdQGMw
 XHmA3CPpQAGfzU0zYW3m6GXKcE78CjkHjEBFSV3n284UJxW272MP8CB5dCGflIzPROwRlBatjgQ
 nXrryJQfbTM5g0zXUqmIrR3QSykzKQg4u+hp7dic5YvkWm7KsGSx9ct88968Q/YQe8n1SThM+0Q
 g/FXmQ4ATBrvbZa2rU8Oqw/EcMG2vDh4hpgaAnB3tB+4fcWewzpeqi9FDVwRxnQidugMJkZ78Z5
 DFUk92K3IRwBLAKmAeepBdB30D7GtnB8fhysF5lHbEmvV9CNl1c+37GMKlgRGKNT8RnrN7fzBf+
 0yg95wzROY1KfxkfgHiNMNF2Yjs45dKw==
X-Received: by 2002:a05:6830:230b:b0:862:9993:2d27 with SMTP id
 46e09a7af769-863159027bcmr900109a34.20.1795111858183; 
 Thu, 19 Nov 2026 10:10:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168bdba0sm213594a34.7.2026.11.19.10.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 10:10:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kumar Gala <galak@kernel.crashing.org>, 
 u-boot@lists.u-boot-project.org, Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <b33d1c37d001192a911db58dbadc5f7223051a7d.1794614217.git.daniel@makrotopia.org>
References: <b33d1c37d001192a911db58dbadc5f7223051a7d.1794614217.git.daniel@makrotopia.org>
Subject: Re: [PATCH] lmb: Check available space below the allocation limit
Message-Id: <179511185743.565509.10208647729764081303.b4-ty@b4>
Date: Thu, 19 Nov 2026 12:10:57 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 23:57:22 +0000, Daniel Golle wrote:

> A limited allocation checks the full bank size before applying its
> upper address limit. If the remaining range is smaller than the request,
> subtracting the size can underflow and reserve memory outside RAM.
> Check the available range before calculating the candidate address.

Applied to u-boot/main, thanks!

[1/1] lmb: Check available space below the allocation limit
      commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
-- 
Tom


