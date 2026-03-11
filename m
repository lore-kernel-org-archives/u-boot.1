Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68A11125863
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 18:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1428415C;
	Wed, 11 Mar 2026 19:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g5JG7u8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0676184178; Wed, 11 Mar 2026 19:13:18 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E8884013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 19:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso14366065e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773252795; x=1773857595; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wy31oyUO2dEpsNHCGjDzF4HKE5dyh7cLqvD7Ty+843o=;
 b=g5JG7u8p5OtVyXNxttl3Op3X0ge8lqxUReejJMS7oXtf/lhX9u8Oi4/AsitS7G/D92
 h+PehgUSPprYlUQRR2qUl9lGnmlPMAkkUc/wVh14+mXN82jH977wL6EHfJWMqY1h5tI1
 CNO/GMUHkJp4ncjbDcKOtn9/XgssPyaofhTt51AT0Yv8wKCCt+6cLamIEVi2jHQgl3mN
 m29S08EqbAMpqioJFEakDMGJugYioCCZT/d4h5lBT8hLLHQ7r/DnoNI1Bjomar5/dhmW
 tVidhZY2Ko3Xd+hMqRVqAp+LBx1tsfuUrGK3toSe+yV0jL7IlqQwCaeUsXuA4v+wZHKU
 ZF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773252795; x=1773857595;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wy31oyUO2dEpsNHCGjDzF4HKE5dyh7cLqvD7Ty+843o=;
 b=ba4YhWa7B/ou/ThD4T4Uq0Vicwx1m4tekEfb4y7+OeEpDPCx+G3aAJNdif12RPPlgd
 9aD2wTtW3TXO8h9Q7/T3epMYLtW6IYYS97XlEWNaAb1YF3caOPhfSgYiJIdaZde/Bq6m
 /xvy0l7PT5qVQeDUbXEsDBM1meoK+Kt2WPscqOM2wzJm5SDMTXHSfq28DnsQVQnek+EP
 3CWLO2mdn64nEpnmkIwdRnA3drCgGrsX9Qd+L6XfDxpmh49QB9X9/K3c9YMlHrsr3S3m
 cRIvbYr6IVb72TIBcbmOs4bmhuIRcdHSuI5dbtRe1b5nKAP9+rAEsQKRMh+jKNhwR0B4
 9uvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUv/Cn14yn+NtoXgD4+tgfeZJ3EJA9OlsSENAb5M/91qWBp+LG367zpCWjPglM0mCa8cUi08U=@lists.denx.de
X-Gm-Message-State: AOJu0YxNu4RgGHJTPEjB8uzKP7F/SGLLYIwkRp0A0np4W/nCcGo+f54U
 yJBF/QG3bPcKWokXqZE1mpRm1+ImkOh2NnZpr26jM1GLt1CP6jVN3sOc
X-Gm-Gg: ATEYQzxfkvuch5QeErn70Fbo8nC6HrKYQWUmHaLfc2N7dkNZqqCUrcC7WrfgNneR7Pj
 4ubbOLSlCcjKJ+u9lKY0aj2eSM7hANMoLFrACsOvonUP97c7qBiNAhKhrtpJiJYw3QC8VgnLrIg
 ti6AjE8ZUDMnBcWxz23YJ1DLPnkr+B3oNIZbQeo0Xl7s8PYerMKNToBdTFCnVS//EOXr6rQwwe8
 OXUuO4x2VTm0Bz67lM4TcK1jmMKqn+IbuGeeOuWC5/x1Sa6pvjfeWO9YNi8QlVmehhzRQhE2sId
 1QkJnlkeICqbPET6VTGk9og22zd7Gpoa6pu5QE2ha538PgI5jq/RJkjBcFc2D6NePAT6Paiqns/
 5PzOaAXMtrX19U84HI4UwyY7pCnF44C5tULNJQRfN+ZxVxNJIxSx0ByPDWzdi0WfbJ2d5Jz6wYw
 VpOx6lYanagq6zRQZMWAFsV1Q8URA/lt/Jkj/vWd1ewttd0kGsPr4YcHwVtyRsZ5aq2hTj7xjPd
 ps=
X-Received: by 2002:a05:600c:46cd:b0:485:3294:fff0 with SMTP id
 5b1f17b1804b1-4854f5a2b77mr9893235e9.17.1773252794623; 
 Wed, 11 Mar 2026 11:13:14 -0700 (PDT)
Received: from ?IPV6:2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c?
 ([2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e912fsm173463105e9.2.2026.03.11.11.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 11:13:14 -0700 (PDT)
Message-ID: <10ee29d8-e0a6-46ba-ab09-dcfc76e822df@gmail.com>
Date: Wed, 11 Mar 2026 19:13:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] mips: loongson: ls1c300 dts and bindings
To: sgdfkk@163.com, duhuanpeng@139.com, u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
 <20260311084129.12809-8-sgdfkk@163.com>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Content-Language: en-US
In-Reply-To: <20260311084129.12809-8-sgdfkk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 3/11/26 09:41, sgdfkk@163.com wrote:
> From: Du Huanpeng <u74147@gmail.com>
> 
> - ls1c300 dtsi
> - ls1c300-eval board dts
> - clk binding header
> - reset binding header
> 
> Signed-off-by: Du Huanpeng <u74147@gmail.com>
> ---
>   arch/mips/dts/loongson32-ls1c300b.dtsi    | 151 ++++++++++++++++++++++
>   arch/mips/dts/ls1c300-eval.dts            |  30 +++++
>   include/dt-bindings/clock/ls1c300-clk.h   |  18 +++
>   include/dt-bindings/reset/ls1c300-reset.h |  36 ++++++
>   4 files changed, 235 insertions(+)
>   create mode 100644 arch/mips/dts/loongson32-ls1c300b.dtsi
>   create mode 100644 arch/mips/dts/ls1c300-eval.dts
>   create mode 100644 include/dt-bindings/clock/ls1c300-clk.h
>   create mode 100644 include/dt-bindings/reset/ls1c300-reset.h
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel

