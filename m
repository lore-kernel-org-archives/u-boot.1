Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720C606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lwg3q2zQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oH5Oxlfx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5119F606FD;
	Tue,  3 Nov 2026 09:42:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kI3RtUui6P_0; Tue,  3 Nov 2026 09:42:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9D37260670
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793698976;
	b=Nmuk8hfkO3/y5CBlwD6Ne2cefcKksN1p/C+RJtEXP3h9EO8uiVSLZNBwT4P+oy9e45DK
	 N8j3t+d0hCN6JVp2jGySd8lLcdkk4ZNCfptzXbHRAPamdIoZGvR2eulOryTc58q0Ke799
	 lmShcek2fsiuWUNt3DW33XGa0Ntii4apbaRQal7HpkCCLqNSLLGDXbaUnDCG8cH8S2Pjl
	 sjNdY5ovWsRN/GYtzuKXQ5lpcT0grP9mA+aZN4AIcBmRaq8TOhC30hK1SuW461NjV/05G
	 Sz5fjN4vpJqBs/nv730bkRE2LlZ+3hyFputvWatCALInzaLbu/UOhu/htnt/r48y8ig==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793698976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ygM3A8Mk8yB+Y76R7qnHkMSg5yzfIWiCokbuBDo68OY=;
	b=oqbbDd2OcmZHibW68J5on34tixjIhmJuK660ulwc8N4OLbM8oXfcaz51UaXzqHIYRlt+
	 /N7DRHQJ6Ir55YTzN3CewIJXGFa9RiJXsKb6THF0F9RZELk7GXIuBBK4iVG43tw9QQTUQ
	 lHOtRcPTdI1HfHTZzk+jF6ygmQi8Ze3oZw843yR2DKf8arus4ihvnKroOzsP/liNmb3Qz
	 0hVamlUq5Y40WeU0p2CHq1a1HiLUOmzDYV6ZhqhrCijbREXz5UYki1++TdFa3vV9xY0AH
	 WjGhl/U1ETN7iRVc3Va1ctt4mJCFV2HuPq+Oh1Zk2Nkyvb7H6Z812uHu2ipXinJC7ig==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793698976;
	bh=ygM3A8Mk8yB+Y76R7qnHkMSg5yzfIWiCokbuBDo68OY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lwg3q2zQTA3cvtqz3fITFQAU36CsOV+T9SXZhoJFc+4r85lgpDm/k0yJPaiYnJDxr
	 fwRDODYqFBJDRVgLneQTs4kM4+XnJIx/rUeUPE3/AScoIidejgGfuvH00t6T56A6k8
	 3yylxEyMG7IyKm+IyRchbrHq2HeM1UDrlG2K5iqNfnDJfjCuK2obv81jaBe8oW3QmQ
	 pTUYUOoZTw3OWOZxCD1LqrWeejM6ufCx/eNm9LmT/S2Xqz53hnk1d+wi4Jl3l+YjH6
	 3T5GS+8EUuyQkJRWfmVpF15QwIx+QQu2vU8+uEI/3FJff0Qj6K1uxQCuAlZm1APxS1
	 8x0sLCtaiTn3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D37260670;
	Tue,  3 Nov 2026 09:42:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CF982A8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0CDA80DC1
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:42:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GVcUTdlWqoJr for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:42:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6DF780D81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793698974;
 b=NpWxwo+ZbLuyuJhnk3z0YsNN0bVPIp+QnsD2E+RDkIyjSC2u+kqwHkPcGO2HnJ3yHmVc
 cGkymkqFxzWSwLHlQH3jklRzW86im/AO7/vRAdgjBhmwmmd0frnkUK3xydEflHdmxVJY5
 Us/kWItkhMZU2JddETLKzpPGunDVJ3Bwfdrc42O5PGIEBu2TqQ6x0IWW8pZRSBIuiW8uf
 BRPRYqiO93d4qDxSBC6iKDW9Vh/kfI74ZZUf1lhfVaFFTKjPsxJvE2z32c1iz2Q1+GQIw
 5sTvIhdiafdKKmKaBFGXq/1nRKhFuvaAdcMao71SFW/4H9dAIiwUMF/qtcVENb6pmuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793698974;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:X-Virus-Scanned:X-Virus-Status;
 bh=ygM3A8Mk8yB+Y76R7qnHkMSg5yzfIWiCokbuBDo68OY=;
 b=VbOgKA3XFe+MjDO8gNmdAicbVcaLV3ZY05WzteRfV/doQRFbFFNFqY83pnv/Ju2FgCAR
 04dVoX9v+1u1xxT+wpnoYF0WGFpAW1CTISscVUrek8r8rEKQ2ctnIyeHMJ7LdOZc0nHvr
 qO9n9RnueEERKVe5XG45xt8G0tjN93DMgfVockzP9uusxOUuYEFiKtVSS6R228vCeHfiQ
 9OJ3fEmY/naSfQM5cixSekffyuRJ7T35uklKxkjSE3VGgWMOmU1pQ9oZRdOBfxQ6lzbyT
 r7l069OJEPouyrW8Qb9+vyFlzT1BzUn6DAr5UE4mpfXlrBkRK/tExTM7du4SM1qapmw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=oH5Oxlfx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=oH5Oxlfx
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A6DF780D81
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:42:53 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2156483FEC; Tue,  3 Nov 2026 10:42:51 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15E483108
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 10:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-91befe703c4so38294436d6.1
 for <u-boot@lists.denx.de>; Tue, 03 Nov 2026 01:42:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793698962; cv=none;
 d=google.com; s=arc-20260327;
 b=Q5W5ada4yKEqjNLABxF+G1pt+eXF2BI/A7RZRSEEa4i/Qbmo4KV8Z1ZkJ1p10G2erT
 GZXHnCpIQH9LZMAdSZzp6R6MgwkmVXYNUJXvkTowJlkXNTsSdG+Nil1Q80l0+oFV3baz
 xZThn0nvE/TlgQKasoQ4YknCCyoypHtBMx9pPgtnQZ192rfknW36H2GNrw8DFZEumCH1
 dVKcoFTLGpNxIn8Ug5SShQYkG/veOs71EpsFnsn4ESSV4rWW7hnZfva6Tcy22BiamcfI
 xqVS3pXDQPweJfC+tDgmXy4AyWrAAaURL7fUzkiJRbxMIt1mxo3+mEZ+ba/blUOS6KU9
 gI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ygM3A8Mk8yB+Y76R7qnHkMSg5yzfIWiCokbuBDo68OY=;
 fh=jJCbQx/2aDsGttN1tB/HwbOUG4CJ5grKb/8ECcFh+eE=;
 b=fZDIGJcIkBaXYtMr0HXCEpb1EskCD837O9qbJNCgOFXfBDZt5GUFkx0H0poaxIprjV
 QRf8gtxUj/bOHbiKO1EVwKjWEXL8XTZH/Lj9x38qWYH+EdqECOXk7CNrilnI1W5X8zlT
 4vJJ5HqzUW6K5FR0Y1ftikFOj4TmAN1IGx8ciGlfd0XMnxr/wPBY5UwEzViNgIxAl7dt
 /ZSs9Dq/EzQM0+fx8lMtARHU9P8p4qYfN8YjVByD/PQifklh1Seewn3W9ppit1yYZMog
 tC1mG4t2LfwWTE/IJiDZ2FCI7oLRRv3AFsxqx+2PUbRpYliqGeDbP9TFC/7r4sOlC0Ce
 HOBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793698962; x=1794303762; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ygM3A8Mk8yB+Y76R7qnHkMSg5yzfIWiCokbuBDo68OY=;
 b=oH5OxlfxxbDySu5V9lB7O/VkxztiarTqip3rillPFrpvQ43Bjdft+dxBqc61QH6od3
 /+SWe+wJgKkN4wS6Iznrnsb0nP9axzL7nEsHZJfIFEHa/KjuumKQ7dN1aw1kaJlXmGcI
 FvMYY+kdj6Nj9SfOrln1Xz0EvhXjAxTOl2N60WtnqtTmQtDvrZmSZTl4i+V3VoPCirb9
 EtlUjVQ+bmQ4B/21JX2sZWOwLPI+FV0xQCvgVx3uOONZSzBwaEz1SkxVgfFbGdfTqKfX
 PJkN3+CKuvXeGAz6mGosqn/qwURFowkCLEnJHsBT1+1EouV/5usX6WWSpiSgTGteSwle
 KX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793698962; x=1794303762;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ygM3A8Mk8yB+Y76R7qnHkMSg5yzfIWiCokbuBDo68OY=;
 b=rjzzl8qEkC3SApzuCdT/Q8AbfTTp+PweydoR2Kq0iOR8WsZpRvIfeRrmbn9nGKElAq
 WYWhP+WpoMcRHY6mQFCfFljFEtcDUMEHeTGNgv7xyB9pdr2/a1EQh+OP9I+B4cMgDjLD
 jEJ/7y+birI1VtAVjr51CUaJr7A5H4SoFQlpO5WMM9qJ8djTZbv3T1jcXG5PPOT8FZ09
 c9wAjitE0PRxsp5Z7Es+SD4YyY0LYN52aCTOEtB7wOR8Mzy/YAzEAivYKIG8oed1kc29
 Wix1NURrYSVDd8dIT67aS+mUP5wcrYen5HAtsfsA169si+uXRLYQkwkMp21uiuArVT6Y
 S7oQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBCzvJl5YcjrAXZRmiVc+BmYmXC2AvGdlBWdD5umXzlr2tPPhOrKeRFAOmD4u9G5R0KrUpmtM=@lists.denx.de
X-Gm-Message-State: APuU4Z/MDA2w29gAPryMmy70wnBdCMHStBQ+BPyJo4SybGan9F7KB8/K
 9q5L/q9f73IC0RyWhZunfxlC0xLVb8l16gmZmh/HQmJTZNMn2+o0r1RFwPQVocl28q2J2hilnDe
 3YE52zs2jLLyxkUYMPeatdn3ihVfei/g=
X-Gm-Gg: AYBFou1MYAQwHjH6eiBLMWqsVBRteK625wVpa5D7YrOvUSye/8Nq82qvOpF8OW9P7bz
 Gl4ccLcjZvVQaKbjh9L4+CCFQTurKq3VzRv8Bj8IZw3bwD0CwTzBx7pFctwbvIXb3ngPj11ayWf
 YjoMvDxJRZ+d1SFkt1Ht1LcwLzUZvsIUyefKDL6WmBNwAYmbPTFvFgca3cx5LSyVBnzBOdqNwyw
 ETUaRcDFtGQQrJST4QVIYB9WC4UdVOxorSufLEvzSZf+ar+cm7H3ztiRle0PA0Y6hxg4AM0oPWr
 UxW4W9GX8pjEVVywRMHfoBMkrpVK25XujI0J1r0AXdVRYQ4J92F4a4qF50R1eKvm7IQgY0uAToM
 NycoCjXBKbkDJjeFdgP6Wp8Kp+HIsOOnRv8P3AnsmlcVO83H8rAo2q+vtjJ0S6XuLR4Oo+R9LLQ
 /ejDCnmShxGj8PiIu27oszT6WPVmh8LCO8IF31NDv+kQJ2BF5OS/WeaCKNVZcY4JpCj2f1zSFnc
 a5te/8nJA5ZOBbQaHVJYGpPXMgs3FvGIK0=
X-Received: by 2002:a05:6214:509c:b0:91c:63a1:1432 with SMTP id
 6a1803df08f44-91ca4a0c523mr207579736d6.6.1793698962464; Tue, 03 Nov 2026
 01:42:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103082732.18483-1-frank.wang@rock-chips.com>
In-Reply-To: <20261103082732.18483-1-frank.wang@rock-chips.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 3 Nov 2026 09:42:29 +0000
X-Gm-Features: AclHuK_0bo6xw7F4NTs3x8_Fx5_oUJweGaSyYZQZgiX4GM4ADEgOw4anhfzXBkQ
Message-ID: <CALeDE9PLaF7rB2RXn9G6ipWW+J5dentCtyNLgdwTUywgiTnooQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: fix abort on invalid ref clock rate from
 clk_get_rate()
To: Frank Wang <frank.wang@rock-chips.com>
Cc: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org, 
 balaji.selvanathan@oss.qualcomm.com, macromorgan@hotmail.com, 
 sean.anderson@linux.dev, heiko@sntech.de, u-boot@lists.denx.de, 
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com, 
 chenjh@rock-chips.com, wmc@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frank,

There's a big rebase to sync with upstream Linux driver [1][2], I
think it's due to land shortly, does the issue still occur with that?

It would be good to get the rockchips SoCs with the dwc3 controller
tested with that rebase.

Peter

[1] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637669.html
[2] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637734.html

On Tue, 3 Nov 2026 at 08:28, Frank Wang <frank.wang@rock-chips.com> wrote:
>
> On 32-bit platforms, "usb start" aborted with
> "### ERROR ### Please RESET the board ###". If the clock driver
> does not implement the "ref" clock, clk_get_rate() returns
> -ENOENT, which dwc3_ref_clk_period() treated as a valid rate.
> period became 0 and the fladj calculation divided by zero; the
> software 64-bit division on 32-bit ARM calls the
> division-by-zero handler __div0() and hangs (64-bit platforms
> survive silently since UDIV returns 0).
>
> Skip REFCLKPER/GFLADJ programming when clk_get_rate() returns an
> error code, as is already done for rate == 0.
>
> Fixes: 6bae0eb5b8bd ("usb: dwc3: Calculate REFCLKPER based on reference clock")
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  drivers/usb/dwc3/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index be198041f08..9a84ec6a60e 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -151,7 +151,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>
>         if (dwc->ref_clk) {
>                 rate = clk_get_rate(dwc->ref_clk);
> -               if (!rate)
> +               if (!rate || IS_ERR_VALUE(rate))
>                         return;
>                 period = NSEC_PER_SEC / rate;
>         } else {
> --
> 2.17.1
>
