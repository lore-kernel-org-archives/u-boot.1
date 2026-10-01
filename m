Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21682CA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 22:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0A7760658;
	Thu,  1 Oct 2026 22:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5OvXZDnkgaTx; Thu,  1 Oct 2026 22:05:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4AF596066B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790892353;
	b=KvZpkcsflNoa9teJuNHOkgFhOinrbvDImEjsp64SctCLZ5hgMFd6pGj9PrbjUMzJ6ZCw
	 62QJCJASJEXlJU2iCfQV+H/3YUjZipj9fZuqdC/GGL7thRZ9vsdw6VBaMTHfWy5DTFyrr
	 /XqthXadF3qeUp+Ycn6lkhM5P7TxXFFCevOXr79d3z84xilTmFCmOs3MvItkHq4S22crF
	 1d/C6psiwBiUF5o4QK0Rfvr1VFdLWoCI/72T4uP90KZV+HGNuRkcQEug0LP/gVnMw1iux
	 rRA82H/OWPLA/SjYeVkhAPQY6lHu8s/d9CE4Yf2dsU5W9gYZRUzRw7ImKvY+7MquMGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790892353;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zmjbbNaiOib6Esx0maMxZ2zHipHS/caPu6DbokAxY/0=;
	b=L0sPGmsiafWj+SniSSCRVjIZ7SRmpBMHtE6wBMniILZUSJGrFpKabQXZWU8gRh5slEdH
	 zYWvYsu1i/BlK0D5RZnz0UP3RiMx71mdeEJoGsBBNk8dOBPAfp2cWJOOPaWRNZ8d1PDIM
	 AMu/Asdc51yq+xNpE87f537XOPYuMMKNmMrH3y36CiQY2I1TzTZzI6aUb+oa2LMg3wOHW
	 imBLTqHnmoPxDpdkRt3oHNCyr4zZYeolREPL1tVSHVCn5AOc6s1QcQmIrgMr+jVj6GbSb
	 gIAQLDpHwoju4hxZgL5Fgsx+u7vG3gpqQMNh9Q0S6CqQBmTNeuzkeZrC/GIawyP0XRw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790892353;
	bh=zmjbbNaiOib6Esx0maMxZ2zHipHS/caPu6DbokAxY/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B897zbK6hcLNpCtuunX5Sv+93uuKHZpVlQWi45llGGW4m9KZOYtLyl2f6+TmSslaJ
	 o9voCjzyiK+qfk8Rns69Fmk5VUm4wseMUw/jXoKbRmCoGysoZOCvNVGiDw+dTktIwT
	 FEIg3qaRXu5UsNHo7NELMhTHe0I49fmra4AuFn7JReJY3JBCx81pHdXT0CjJ9T+6DZ
	 w+3sMLqhS1O3haNmV2f1pkjDIXVN5CY+i0XuuyVSgrEq6xz2h1KS25EPXqGVtGfKbY
	 6CGkP/PBaq6OGFJCu4hBDtm3NHygD4glKLqJYmDlk9URd67lT+qW3b0b8PD2Fh9z3C
	 vbHltBjHg4bTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AF596066B;
	Thu,  1 Oct 2026 22:05:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F086D3AC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 22:05:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D642840062
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 22:05:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZD4c_qCpXuju for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 22:05:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2D6DA40022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790892350;
 b=ETdRoRja7SPOFyKxTKnV5ch/lzaeTGJcb6ESmYh10fcJNrRqjgxUadWoeFW8ItQyTo5Z
 yj+NFPY+mQN5erlCZn+Nv/Jvz5DHxY9C0aJgfVDIskcuH6vNehyEL0s4qA3LnaSiGP6AE
 C3pDqweVwvutdyIu5DuSknIu9i2A6kfnlgvTQWpEHf8/9pVPOIpEMUvqhh0zDpUTmvvqQ
 53z4+XGGigVQ7WiF2xvAgGsVEWtq90nQWIBtnydMEgoLEbxTEvmmJQS3geQhULweFasEX
 94bG8Odbwr2cVJtQQ0kf7fmwm3Rk6LG5p0va1RV1xQHUPgzoj/NNX3ADrJ74yiYQgBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790892350;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=zmjbbNaiOib6Esx0maMxZ2zHipHS/caPu6DbokAxY/0=;
 b=eQTirlq//4TAmvnN+XcSoiLe5trvC1nz9G3NKdnkbat0oDU8LuXTWWeUogpSKMLQZ82D
 nvljxu5p1HKkVwb/dMCkMaWPOaWQbxOllcJGnNtjZ6NvTLKjJZuyVzAuQ6hYZDRLR5Zn0
 jD6ZBoTFC1pGwq8qGWgi3xp6igeugyY3qxB8rbFV40etSjXKTFsfiPSJJOlTj71e3WHco
 Q2+nUZYgzYN/vd9nvnA5nrrxNNpj/5+o/QY6yPU0T2yTwI4677hNc7E0NMUwRKYVKPb8P
 si7ME3obQH0t8k97Fs6Ia1+fsUVuuAFAAz7jyr/poU6OjCkcJ1xEq+9NwKzN0aZqibQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iJNsM7Ij; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=iJNsM7Ij
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D6DA40022
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 22:05:49 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-81b15bca7e0so4143055a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 15:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790892348; x=1791497148;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zmjbbNaiOib6Esx0maMxZ2zHipHS/caPu6DbokAxY/0=;
 b=iJNsM7IjOVZOFzCxsqutJfEkeWPSz/zABi0wIG5FQw3/8lH+7R0FXAs194q3aw6GOz
 YmOxAbq8c4GtQSCXRwAA3gvMIiNbG1VQwe+TH15i+BLsMcRuXijdGT7QzabaK10EdN/D
 oS3uuwtaeC/YTcRuA6EHd5YqCHzpP9Vv6+L2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892348; x=1791497148;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zmjbbNaiOib6Esx0maMxZ2zHipHS/caPu6DbokAxY/0=;
 b=Hs/2X2Oo1lWhCaycgz38Ky1uVmIF/4nfhgcVvlyTm525nG7Rgus32HLpYYk5A78yP1
 LOE8sCnrV+OdKosNgFzE4PgW26xmRlZj4fBGXJlp23bV+MYLxSQZKq1QN0u/2U+sazJs
 9W9lA8lqc9+dZq6EJoYA4nMZqfGxaCDPAA5CYFFNEuhK7Qqbd9uEB9kdofBainqoMZjc
 AgIAUBoB+mLheIxVJwZfddNU7ORje5mQWh3WhxfJQHyYzySUdJa1mN8ULPCjrAx4MDua
 Xiib6Aw0Y4ydxv93y75IEjldEiz0SpEzkq6OYiGa7IywKDCDjCyJjmlUZURnoYoSM2iI
 m5LA==
X-Gm-Message-State: AFuF++n8jnJ609pr0ZaYf4RXYO5yYr6v/jGrU0oSze0kS/nodauhjMgV
 XvYJaTOjKKnyMU/gPkief4RAECOQTsbxw0oIuaN+mWHPJ2K9o3UDdE7wovGnYOjKgMwHp9Ot/UK
 48nAZMUGIoy8S
X-Gm-Gg: AYBFou38ue66BvmFkm4jzu3agWhZblzEH5JKBJeoAHKHZ6h+M/dHGM9Tk1OCbpBY4IO
 FP/zsRE+LuJpOK7+fZoogCbqxQZ/zK4L5A2gKE+wJxGcVrARZdK17khyfJvmBY6gtQ2E4t0DJ9j
 PlGcMjgUWkCoZxdfXZMb5mwnR7xduD+yNFIXRJOONgPuJq/f6DAoqnmQZ4XEbcLE0YFUM2pMlZI
 yb+LwCr95vv0wU4MY1vPhNHtFkZLAgo8il7Ck8ZeyBQb/HZHAdrDC9P9DEtDzgfAl7rsau3opWi
 D+Bunx4G4w2OlvG9WYmPwezquXRAswwGmEVbYGuiDpkJTwLXy23HuVz4Y7hC2F/SWewIHOY3DY2
 hnMQCmvzNNTRYLE0NSjqez6r1D1GhyGDMAJSxTwRo+bXrIzqavM/8tNOuGtHamiLhAusM4lPTda
 +QuYjPiMaJFl06SHtwgpmPNRsQz5phdBLh5HMWEoWUjsvm+ho7oXwqBGiOiqai8pBREEWaYJs7u
 ONunRZIjOwK1C84LgQgc2jBkhlqNFee0Zz2X5IoH/7bSlgh+ebqifAEnL5Hsdc8aWM98j8dfO+6
 Zu0jWfSuhBRJvasl7xehDucA+7IcJ213ywnDW35CKpI=
X-Received: by 2002:a05:6808:2381:b0:4e9:a959:7a4c with SMTP id
 5614622812f47-4f52980a880mr571893b6e.24.1790892348438; 
 Thu, 01 Oct 2026 15:05:48 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f5243d47absm484897b6e.8.2026.10.01.15.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 15:05:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Petr Hodina <petr.hodina@protonmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>
Subject: Re: [PATCH u-boot v2 0/3] lib: qrcodegen: import Nayuki QR Code
 generator
Date: Thu,  1 Oct 2026 16:05:44 -0600
Message-ID: <179088838698.888564.1160331783156715319.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911-b4-lib-qrcode-v2-0-c5291fb7c646@protonmail.com>
References: <20260911-b4-lib-qrcode-v2-0-c5291fb7c646@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, 11 Sep 2026 20:25:14 +0200, Petr Hodina wrote:

> Add a small QR code generator library so U-Boot boards can encode
> arbitrary text or binary into a QR symbol. Main use cases include
> displaying URLs, pairing tokens, serial numbers or
> self-diagnostic state from the bootloader (e.g. during porting to a
> new mobile device with no serial console or usb peripheral working).
> 
> Optionally apply gzip compression for the QR code payload.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] lib: qrcodegen: Import Nayuki QR Code generator library
      commit: b556c2eef228ed0fc46a9269623c251f12c3b97e
[2/3] lib: qrcodegen: configurable maximum QR code version
      commit: 5e66ad00798bf945a70ba9b56c345686fde21262
[3/3] lib: qrcodegen: optional gzip pre-compression of payloads
      commit: 1f98f086b125cb68693bb0862bbbd9c6c2aed34e
-- 
Tom

