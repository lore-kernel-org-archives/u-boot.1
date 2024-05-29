Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6DDC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 19:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01828860D;
	Wed, 29 May 2024 21:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qy6c+hnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF3CB88626; Wed, 29 May 2024 21:02:16 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C476D8854B
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 21:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59a609dd3fso8915766b.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717009334; x=1717614134; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JXhe6IjUT71GEHCmutQaC2+/1yu6puBwUmEvGNZoWZc=;
 b=qy6c+hnZ6D2O9nFLF3or9yd0Nz/EZ1aBgNc3rb9b68j+wru7jp4RiQhL75BZhaO69n
 Yufynq+fERZte4D3SM7ibdno1TYPi/ymgkUItjwIv9dk2+SQhJRBDX10ekBE/IZLwjwy
 MbFbn9Rz91zoyAmp+IuPQtdm3qke1d0xeaSaVbXTXieBO8vWgkz4dfe9xyupehhYcg2h
 CsNbXXtvj27OPq9QGWmRx9FkKzF1YLepzr0LwbQVipLZx0j6NQOFBCNdX2XttbbgtR/O
 ff9Y+0iNv3UFpztLbzBgFXchfaSDLdPViVFJBGt9SdUL6bnXoWqlJVF1pK67HW1LsD/6
 ZfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717009334; x=1717614134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JXhe6IjUT71GEHCmutQaC2+/1yu6puBwUmEvGNZoWZc=;
 b=HRnzuZXfIt/WZfX5tnffO3S0fd3hseQa/5GpsuuqyyT5MwrvcS/mor64peRnlG7DsJ
 9hoIjyaDKB4YPrj+8LEGcpamvYGFMC71Tq7+lFiUF+eemZiIloNn7AJcRzJKfV5i1FX8
 KB26y1EL7MZMcAEQzvrpg6N9CDYugkbjqbr2UslvnVBS5J3AbeE2IgGe/oM5HkkCq5I4
 Wk8WiDQmt47f1Ed0IzHfdyskNF+PgDzDrrlE5vZzpDRKXyeEdoL+xvK4eRLOXR8Kl5im
 Ya37lDVf12ex4h5/XhFeFSdq+l6KP+eTsNNf8fL/KHUaOdbJdHmDv3dbSrSAvFewZRNO
 dvqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu7TM0EvRQwpKu6vdUb8uVrUWoZMQ7uLh+yQ0nagi9C9lXJi5mIusbgAXWPul+5qWr4ZPpzJWVT0fnVk0lRnAaCgBE3w==
X-Gm-Message-State: AOJu0Yx4NtCWXHR1oz0v/uoGnsMyAtFPK4kYpCB8BcfBc+MDMWlMowLP
 niItBEuQ5uqF2sISOxgd3Kwk3gygT/yNNCGAht6Zo27jrhGcnNpcGQU7R72rTqU=
X-Google-Smtp-Source: AGHT+IHJxYyUMNc4CTvyxp6B3zzmJ+mNAh3YEScDOJLMIPbWSrCBZvykIWzbC1g1VgQ6LmdSUX8BSw==
X-Received: by 2002:a17:906:48d8:b0:a65:ab74:1e98 with SMTP id
 a640c23a62f3a-a65ab74325bmr155229166b.9.1717009334112; 
 Wed, 29 May 2024 12:02:14 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c934fd8sm740362166b.47.2024.05.29.12.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 12:02:13 -0700 (PDT)
Message-ID: <fd581f3d-00a9-4389-a9e5-e1fb8b5b213a@linaro.org>
Date: Wed, 29 May 2024 21:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] tools: add genguid tool
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-6-c26f31057bbe@linaro.org>
 <CAFLszTgtJi+QE4Ry70jDJbqg3rgTMXEqbt-RROQ1kQwR1Qv-Ag@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTgtJi+QE4Ry70jDJbqg3rgTMXEqbt-RROQ1kQwR1Qv-Ag@mail.gmail.com>
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

Hi Simon,

On 29/05/2024 18:30, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 29 May 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Add a tool that can generate GUIDs that match those generated internally
>> by U-Boot for capsule update fw_images.
>>
>> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
>> with the board model, compatible, and fw_image name.
>>
>> This tool accepts the same inputs and will produce the same GUID as
>> U-Boot would at runtime.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   tools/Makefile  |   3 ++
>>   tools/genguid.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 157 insertions(+)
> 
> Where is this tool used? Can you add a man page and test?

It currently doesn't have any users, it just allows for pre-generating 
GUIDs ahead of time for a given board. It might be hooked up to vendor 
tooling or some usecase like that.

I've somehow escaped learning Groff before now heh, I can give it a go 
and write a test.
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
