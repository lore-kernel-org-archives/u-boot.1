Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AC606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H1Vp/9p3;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=U4tEBmjh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03AF080BF5;
	Mon, 26 Oct 2026 21:24:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_Hu6gHUk1nm; Mon, 26 Oct 2026 21:24:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2417380A92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793049876;
	b=IJY3mtTwp4QYRljyBfZEAsmq4lADdpLW6LpCXcIY75ci6gOq54Pe/SDmtFIRFGS6DExu
	 xJAl/DbTWXcGQM0+0XPEPG6WvT3JE9iEAd53DBjoKkvZxcVNht33vOASiUBysI+oCqSAN
	 YilAuG1ElwgRjD88CAd0VS33TJHExnnVn7KLWNGULua+yCo2jbMz4WoVqZ55C3qcK0Mlb
	 3lu300Xf8+ujmyOA+6cIBLjE1Vx0RwFN0WOefLDUJTI8ACkEZiujZCFC/is7oQ4j7QqOI
	 XwYYgIyHSeG17lxbZVTB3ao1l1qcbdeATPFMfGDdVEQQhaDzLvgbUfptKrhcSghqyCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793049876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Qbhg3Mmk1btsGYeCuIzDh9LWol5KzhA1ahMog1lKrng=;
	b=X6xrF2/PQrp2V8V8kpM6eTr2MUwa/eCP45XCj6HkFz9sTRnKoPKLnTTP7jZ6KJG4xrbc
	 ZmBHYpt8WOFpJ4n50Np1jZ8mGmbP7DiIRYUK1aKjklIQhJvPqblEsSbvjtgkMGRJimnXT
	 9CroyT7UoLtPZrCBR2L/vnqOFSyOM9hHbVMA60oNZpkNMsq/aivb1mYzA/QxX9AmQdK65
	 Dv8LBcTsHGS7d6FPlLJFm+v6Ur65dVIuLySPKvaH7VhSBgaPEdmKYT19gMUi8CiJZ8TcL
	 y4mQR8Y866xw3Y/MRhOznHovqE91a2tWAyKLLPppTuZigsgSt5Rh6jLikGv1Lv+NcPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=U4tEBmjh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793049876;
	bh=Qbhg3Mmk1btsGYeCuIzDh9LWol5KzhA1ahMog1lKrng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H1Vp/9p3bcuDcPGCPIDO6/aivDolsowDNFTPHgLVuuBFSd3fdsU+AYImW2a+94UFq
	 mIm+f3W/u4UljROROrSgG0ucfv2oiWBuU6E0jZtP0g6ftENeGMrwagfP74aEnsVT2/
	 AD1AG1JebcxxY+Djfzhq8LKvBwOvdFMaOTrVlezynxn0YlzjeigXmg4kEIuN/rqnlO
	 rRbLN3IOqvPwF96DtEvAZUvWx73WB6H+XFtNAPUnK2KTGMVs8+zyhK1Oj8eCVu1AZT
	 y7gkdk5pb37TtOC5St47sl4zL/7BsqW1rKprwK/wQ4CjbzS/7qQLxLRB15HAV9Wste
	 qv0eCBscveGng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2417380A92;
	Mon, 26 Oct 2026 21:24:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A3AC84BC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8923D80A92
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:24:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZWsqUrhXN1v for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:24:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 69F9980A54
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793049873;
 b=hox6RvXXS5fRNqkXt03Y+Bp69NYv/oS2Ba37p/ueI2ZGhhmKffHmLTso9gN9s43/jgPx
 Yt9cHZY3iiy+obHu9Pgj62qGrFTQVWTB9PIU8LFIrTcf3DxBkXEuNm7wo75/Cn9fygQeb
 roMiyP8vxjfsmwBmum1HbbM71QLxskZSYmxkS9Sh153dOnSJDOnuInWpom6ZpSWa57zz1
 17G6Uq1PY9gqKht5bS4DNTECYlt8SZF4m95lciy73XL2fOtGCZ5E/qlCAyaYTwMZO7dS+
 QO/eY1T5STCBcXvNw+is+VwRBoYqUU1K6m7eDE0OuxnQ5MK3JkqJ9X7Vbo7+WqJ6lhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793049873;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=Qbhg3Mmk1btsGYeCuIzDh9LWol5KzhA1ahMog1lKrng=;
 b=W8WywIL9OMJY3vZq7hSD4cvuicZ9Wq7oJII4VgUPR/tgJSk2UVwZo1bqGW0HtC1stZfT
 gCBqjlq7kRswdwghhzZtMa6XD0+t2xa+1pZEsG0dHgdq2BCH08Dny+GMRraF/cMPKXBXg
 k0tjlmcIkNoumke4LguJQc+DszIs2ZMnRYwc8TlpueMC/mwS5wKwLTdXyXV69rTDInYZ6
 LZhua4g6c/IcheMl43kpFfbLaJ6XPvB6mzyQDhVThPnAoZ4J8//f9TVRZTy271Tu9m7Gx
 eXosYdqFHheBkoCYtP6PjgY38/MB6UtCFe/QX60AC3frevSbNmPyVe/cTiWNIjw3bTA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=U4tEBmjh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=U4tEBmjh
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69F9980A54
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:24:31 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso3553570f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793049869; x=1793654669;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qbhg3Mmk1btsGYeCuIzDh9LWol5KzhA1ahMog1lKrng=;
 b=U4tEBmjhTuuj9xFUwBtTQs7s6oVVpFU+zXVPDZCgkvrQf4as7mlvWFTKgKwSlNgI6W
 sudfq+T1SvJVZ9HxCDDDxqos6ONg5B1/HosDtv3pje4O0dCV7Yi73soypVZ4olKlF4Ic
 7dTVjI4ApgKvR/BjQ8BKwiyrlzSalQKzFo7URXbLebxzKQ2OFXjjiMvr8AQ+CVUHRXqw
 omcsmPKxelhR4SG0vYDsfNJ9vOhqtVD+c/0VJmx5OvuWfqc2fQ8ikp4Wau8QSDCw4SJf
 l1cdqJAjxpw8sVohJQk/dqIE4NWU/FIs+HvxOk1ua5cFiErxKD27uyeZyyhJam5wJnrw
 FKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793049869; x=1793654669;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qbhg3Mmk1btsGYeCuIzDh9LWol5KzhA1ahMog1lKrng=;
 b=UcTk+1B/iPqgbPcswDrqh46vfaxvhOVY0RSgK9F2/C2n+o4rWSxjlhE6/XFcig1U0C
 GWcxcFvKQFv/jjNXOs6wlAxQvnHElddBcPhaRVi+bzQ9gsSqPQYAKq2Hnr6B/J+6Nwql
 SIIY1q6PmunSz3foLUCmnZJzY5yUtytJ3vntiQn6wNTziRQCdCdGdn5Fgz+lbZpKRbgS
 FtcvYGyE+fjPiFgDLIMbSvxncYLL4+n7RTOLJztTFCxwc1ABxyPFzQIiklBjced+cBfG
 ulZltMbgurSwiRgSOxp7PlcSAbiPhtviic9ooHowCGkQY6vw9I4vhbnFmw6fg1hdKjBn
 CL2g==
X-Gm-Message-State: AFq9FYJcunbo3/AD+s7YpRQKwzWcZ2uJc/7hjw+4z2puDoL/xEpbsTAs
 BddmPs4zhf6HaJMmgCxvkodfufOl7LRczYi5biTCwYD/8hrcAjxNxUhvHFVUY4TeDrZV/EasyrW
 cz1sRa43ptA==
X-Gm-Gg: AYBFou3v3LueiKymnXu49sErAIcJr3xl6++hX1RQXRlely4Cnyd01lx6zUO8Xyg8hWI
 WNy9ntcCT92it8iVATgvXY6H9xRcsLKE2zJkFzz0DXltiIZG/XLLN4vwQxBwLEL2G8k3w7aNGbO
 bmLRu9p+/c3CSZc+Ie3PeGfy/03vRNoeTclDUnT3wgsxLiv/MSRyM3lN2zZkJghH2UO9PHAWdwf
 4/5BGD3PZCipcgZPPjhzJg4GiZRS6bxpthOqkBDfihS3ScK7fygPJpRxKPwVs4z5H0vDUY6BKAO
 aNRNsMdjO/QY8NEvXULfbMkLFSV+UxCyKpQR4H9qaPfaG1O7nI3kVUgQAHtnzBzgmfJH8cYGn3w
 VwdQhbKHEjbWqOUsyphU+7bvZOFLIRqC7VZc33gkI6AJKLQAQLDCrcpwQpOEPym+pHPK1yeI5we
 JjT2ex2YZMyNJ8vFm1phEzfPMwqrp8p//rUmim6i2Np4kZKv06k1xSJlROY92pwvjQdTDAPFtai
 GTlJff2aqnDuqnfXXbWG+VOx2o7FRoNt3ow6gxrue+SkdlughujnepgtDuMLkO4mFFaXtpr6z1V
 JmKresFnh/kapKyAB/drxZJvTOE0HQ==
X-Received: by 2002:a5d:650c:0:b0:48d:dfff:fe6b with SMTP id
 ffacd0b85a97d-48e3eb7b517mr11989095f8f.34.1793049869359; 
 Mon, 26 Oct 2026 14:24:29 -0700 (PDT)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb902sm19531046f8f.24.2026.10.26.14.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 14:24:29 -0700 (PDT)
Message-ID: <5cceaa35-66b8-42b8-8b57-3da71f032199@baylibre.com>
Date: Mon, 26 Oct 2026 22:24:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] env: flash: Add an erase operation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Aristo Chen <aristo.chen@canonical.com>
References: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
 <20261026-clegoffic-env-flash-erase-v1-1-18777abd1bde@baylibre.com>
 <20261026210850.GK646438@bill-the-cat>
Content-Language: en-US, fr
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Autocrypt: addr=clegoffic@baylibre.com; keydata=
 xjMEafx9bxYJKwYBBAHaRw8BAQdAtc85GIwDXLz0rh9thWXC80Lji0otVDVncXT4qaS4j1fN
 K0Nsw6ltZW50IExlIEdvZmZpYyA8Y2xlZ29mZmljQGJheWxpYnJlLmNvbT7ClgQTFgoAPhYh
 BJjMiHuM4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEH6EW4KtCh6Tt+sA/jVC35rY1npFlOy7YnncTdrID8Qf855JA78IzXgvzpGp
 AP9FkuuT80m66PP3DvgYX9kVnG17mSDKO0+v2W18v6ZgCM44BGn8fW8SCisGAQQBl1UBBQEB
 B0DMwF4u//aQyzsFlO8rPJ/cqsAuPH80IeIA3HOEo5mlVgMBCAfCfgQYFgoAJhYhBJjMiHuM
 4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsMBQkJZgGAAAoJEH6EW4KtCh6TdSgBAMDS0MiWCivt
 LjzZc9bs+P/xdXywUjDKq3lpQGJ6vZ0GAP9vI6DnN7vwVK6jt6/+0aBGkog5Ura9+WwRFEdM
 vLfPDQ==
In-Reply-To: <20261026210850.GK646438@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 10/26/26 10:08 PM, Tom Rini wrote:
> On Mon, Oct 26, 2026 at 03:41:02PM +0100, Clément Le Goffic wrote:
> 
>> The flash environment driver has load, save and init operations but no
>> erase.
>>
>> Erase the environment sector the way env_flash_save prepares it for a
>> write: unprotect it, erase it and protect it again.
>>
>> When the sector is larger than the environment, the rest of the sector
>> is saved before the erase and written back afterwards, as the save path
>> does.
>>
>> With a redundant copy, both sectors are erased: the active copy
>> alternates between them on every save, so erasing only one can leave a
>> valid environment behind.
>>
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
> 
> Using LLMs is discouraged in U-Boot. Patches 2 and 3 are trivial, but
> Claude is tagged since presumably you directed it to implement the whole
> thing.

I didn't know and already got a private mail about it.
Thanks for letting me know.

> 
> The commit message is one of the things which bugs me, but it's also a
> more minor thing. Handling redundant copies correctly is an expected
> requirement, not something special to be explained, and is something the
> other environment stores handle too. The partial sector case is
> something only "raw" flash types have to handle, but again, all do. When
> handling expected functional cases, one should just acknowledge them as
> being handled.

Right, I understand

> But the commit message nor cover letter don't note the real problem.
> That is CMD_ERASEENV can be enabled for ENV_IS_IN_FLASH but is not
> implemented by the driver. The next step here would be a quick check of
> which other backing stores also don't implement erase and then updating
> the Kconfig logic.

Thanks for the idea, I'll fix that in v2 with the refactorisation.

> 
>> ---
>>   env/flash.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/env/flash.c b/env/flash.c
>> index 31dd1656e721..4b402437eb77 100644
>> --- a/env/flash.c
>> +++ b/env/flash.c
>> @@ -310,6 +310,66 @@ done:
>>   
>>   #endif /* CONFIG_ENV_ADDR_REDUND */
>>   
>> +#ifdef CMD_SAVEENV
>> +static int env_flash_erase_sect(ulong addr, ulong end)
>> +{
>> +	char	*saved_data = NULL;
>> +	int rc = 1;
>> +#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
>> +	ulong	tail_size = end + 1 - (addr + CONFIG_ENV_SIZE);
>> +
>> +	debug("Sector tail to keep 0x%lx\n", tail_size);
>> +	if (tail_size) {
>> +		saved_data = malloc(tail_size);
>> +		if (!saved_data) {
>> +			printf("Unable to save the rest of sector (%lu)\n",
>> +			       tail_size);
>> +			return 1;
>> +		}
>> +		memcpy(saved_data, (void *)(addr + CONFIG_ENV_SIZE), tail_size);
>> +	}
>> +#endif	/* CONFIG_ENV_SECT_SIZE */
>> +
>> +	debug("Protect off %08lX ... %08lX\n", addr, end);
>> +
>> +	if (flash_sect_protect(0, addr, end))
>> +		goto done;
>> +
>> +	if (flash_sect_erase(addr, end))
>> +		goto done;
>> +
>> +#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
>> +	if (tail_size) {	/* restore the rest of sector */
>> +		debug("Restoring the rest of data to 0x%lx len 0x%lx\n",
>> +		      addr + CONFIG_ENV_SIZE, tail_size);
>> +		rc = flash_write(saved_data, addr + CONFIG_ENV_SIZE, tail_size);
>> +		if (rc) {
>> +			flash_perror(rc);
>> +			goto done;
>> +		}
>> +	}
>> +#endif
>> +	rc = 0;
>> +done:
>> +	free(saved_data);
>> +	/* try to re-protect */
>> +	flash_sect_protect(1, addr, end);
>> +
>> +	return rc;
> 
> All of the CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE code is the same as
> the saveenv with the variables changed. So a refactor is in order.

Ack

Best regards,
Clément

