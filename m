Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AE606A8A7
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JxBpHnhS;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=monJ6E8G
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 478318114B;
	Fri, 13 Nov 2026 16:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IjTMo4x3jm0z; Fri, 13 Nov 2026 16:47:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E95D80F34
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794588478;
	b=WXtW0ORIb7k2DWlaP0Ucqup3JlseB8uVPjGJTgE5rYX91Hq0W7pPLZQY92iq9+rcehGg
	 DdO4A9qLN0kDjF9QhrZZlrrflw+TlWMulYIwWGWj4XqCsdsfiKgfVsszEagdEypNqwJSK
	 mNGLWuOsp3tTtEEJiO7CsKBYEikgNeGiqnLalK94SThsopTYdkjgafRdxVBks/B8Rz3vy
	 VxwmzxwHHx3n8vgqMSjDFquw6MHzsjSXM/TyjRV/qDzys1IMb5M6VQzym4zw/qYFWlFnv
	 MpmkNVVn/e9SXuPH6KeSQHZNmz3QwxgPVqDksSDtIQobLdJl+CSizRClj7dqu8bBw2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588478;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uhQRBmfm9jXCfrr4jW29rgGi58c7NGpUa6ne6YzRVNg=;
	b=pzUOgKM2DwdS2AsbEh4iSb2ukSF1u4ficBT0aVxHHXdv6FY0k7UMI4Yos3VjgYHE438B
	 AsnqsGUn4mCP+Qbkd8cunMj5aK9TRzBvWPTAUsox/y+nWiC/QoUaawcEUgCbtoGIfXkNm
	 bvI3NKxkvG7UBk36Wn8w/JvKwU2mylM2HFax09f31sVkI7UqNXRc8ZQYeWs0BPmadTQEC
	 5dJgOOpsn1MHsXzynkxA1e+oOTP7nIhIFD+KhHIHW+8iF8rD8YKdAOs9PUl5kx32Tz6LC
	 liyoTgXkPboux9e8pHQw0XQ2BXY5KWTAxl7UeSQol23aRa4GQPiVfXhe2iW+pIcif3Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=monJ6E8G;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794588478;
	bh=uhQRBmfm9jXCfrr4jW29rgGi58c7NGpUa6ne6YzRVNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JxBpHnhS2L1p7yMfsYG/ivGwu9NC6wojbOJDdarmrIgMH1rkggcOA8Wem+vORpoal
	 WbSV+XgCxDajN9rtx4PEJD6dx+smgusiQjELoSY6zkUul3AcNEHXWe+yYdnTg7M7V2
	 jzuCehxHZjnmLFpzrTotStIAmgDM/e4/CL3YxgDLSvKxvRof629UT2Aa10MBprIqNG
	 Htn2G/7Vi8TGaflDfDMLgTtbCHrsL/MNqyIJQVPhxsqhyybg+G6QAV1tYaW1UjAo3g
	 iouMvu9d3FNzO4S88L/5xdavpfro0eVwLZbWbj2WhZomNu9tpR1vq30aSd2CKDPSYM
	 9GY+jLxnDm4NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E95D80F34;
	Fri, 13 Nov 2026 16:47:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5870178F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA78780FA9
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c36UOtoXVqfC for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 16:47:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6ACFD80E31
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=monJ6E8G
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6ACFD80E31
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:47:54 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-491971ac844so1413735f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 08:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794588473; x=1795193273;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uhQRBmfm9jXCfrr4jW29rgGi58c7NGpUa6ne6YzRVNg=;
 b=monJ6E8Gh2NxXuUenDUF5fgEGp/L0HngMbdjMCpDhyAYZ+PxCMg617IPWNgMjac6CX
 6HnPENCV2lFYlYOlAAB8hA7/f98tMG7yoOnmI7YDFIT4SxC/7VW2yIdiFDXWxj+04JLS
 uv6WQkgTFetxG1pQNPNg9E9mOLs8x/uEpm6qC9OZ9PyERXyYHs/uYescyc8pngK6lWA6
 XqN8FbKYxOYQ9Ykd+06NAq4X/YJ3XAt8MJT28UwTDpR+pAKVdJ9JUHULYg7ft6tKisBw
 qvbfM0TI7BTViywtRqYbKXWLemfRPMbf5rZL7u1nvdOABwxQ1Mgg/c3znkyZsjq6JX5o
 c01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794588473; x=1795193273;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uhQRBmfm9jXCfrr4jW29rgGi58c7NGpUa6ne6YzRVNg=;
 b=A4oz7nXy1LJqInQUrpPv+o1muzxw/ykzJJDMR9RvKYEyG4NPKLCj37+AZuFPI/WQvf
 M2fGrx8iqqKSnmptD8DPObe4s5WPApm06bWRiNiM6MYaX/ncK9XdsMmWdxFY4LiFq5FX
 O1DHUCuo1CnXugdpf3bGjcg0lWbe98eB5+iX33Dp99yf24j7oW9jULWrKfuhWma0A7Ow
 90yv3xD5K34BAIFbEfRNlNdsK8uXctGdQA8YhVcWioeiLAfiPtv9Mz2E9RUQ+q3TCL7Q
 4ZxjB89CizIy6FnuoOm1kHo3TXjXySA8OYMfBjJWQGhURETk/e7J96z1hlmTD2uDsPwQ
 X+hw==
X-Gm-Message-State: APuU4Z991fApxXeT7lVlG3zyT54bJp8jGHl6JRxNriQWNN4LiICex/Ai
 /ceaKBVVdNc1B3XdRvxIG71tqGWRT92ThJsr2Drp9POdGqSSHdLWOIsI8hwMCrUh7K4=
X-Gm-Gg: AYBFou3T3p2gNpWA5RRRo/1H4zg5CwGZkaGjyomAaThDSn43aiw1dHS7KYshWrP9E99
 UB1m4w3c7HXcBDQjPORfwIznkaiHDWXV/FhU9H/cN5gfSyLQuc7SXIeU1+rxNWuukLClk1aD6Ks
 ouRxF1MmuXs/bNDaJVcdvZzl5j2SG2C8JXjLQvE2AfFt2hEcPFnoEuC+JDlqKAtuieNVVE1EWIX
 r6y6/3mFCqsiDu8eH4ApUp2Dka4zwaPaZq8ed4RJ2sUDOiLl5ytgO6tQztDkLjkIq1XUiKA6iFY
 pzxxYbdMr8+8xQf51fgd/Fyc7WBd1E6WkrJff8/Gc/hw4qn7FdyuNZhDEEnUdoyPEXIKfbqPSAa
 drjpFMEnKJ1U9kvK3DNgPBPdwleulT1KJoe0GZ+VIpyw7jJfY+2erpylJ41ZUUXGgymC7RLAFiJ
 H57wndcMoWgEvLSl6zzdIl5UtB5C0jsN/Aq7+cDqMKSoTBPTgHYOEKIQs6D4hsuNejsVzQQ+KpA
 ALZgQit2YukJ9U7yKcchNMquJiqAXC7rV1U3RgoSmeD6QVf+uqSqtpLOgBEeWa7auZ0RsgABu/s
 LzHQgOVw0J6X5NO7l4QGMKCK4B7OiZMgR0/MaJd5+mRVSRMz6YPfF6uSzHDbFSBuYVH8RBktigE
 qWy3DrRU=
X-Received: by 2002:a05:6000:470b:b0:492:8dd4:baf8 with SMTP id
 ffacd0b85a97d-49c6d453907mr6871193f8f.6.1794588472841; 
 Fri, 13 Nov 2026 08:47:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:d1f3:b31f:cd8a:dddb?
 ([2a0a:ef40:e16:1f01:d1f3:b31f:cd8a:dddb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm6891898f8f.11.2026.11.13.08.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 08:47:52 -0800 (PST)
Message-ID: <78111088-8ad2-41c2-9323-d6a65e03d83a@linaro.org>
Date: Fri, 13 Nov 2026 16:47:51 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] Fix 'make check' errors
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Kory Maincent
 <kory.maincent@bootlin.com>, Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110145550.GC3741582@bill-the-cat>
 <fc5535b6-d967-4890-96e5-337c6ea5c23d@linaro.org>
 <20261110165712.GD3741582@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20261110165712.GD3741582@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 16:57, Tom Rini wrote:
> And FWIW, with this series applied on current main 'make check' still
> fails on my dev box, which is just Ubuntu 24.04.
In addition to the packages documented for building U-Boot in order to 
run 'make check' and friends you need

$ sudo apt install yamllint cgpt xilinx-bootgen u-boot-tools softhsm2 
vboot-kernel-utils opensc coreboot-utils libengine-pkcs11-openssl

You also need a built copy of fiptool which seems to need being built 
from TF_A.

cd ~/src
git clone --recurse-submodules 
"https://review.trustedfirmware.org/TF-A/trusted-firmware-a"
cd trusted-firmware-a
make fiptool
mkdir ~/bin # if this did not exist previously also need to logout/login 
to get on path
cp ~/src/trusted-firmware-a/build/fvp/release/tools/fiptool/fiptool ~/bin

I hope to do a an update to the docs to make all this knowledge 
generally  available. But that will not be part of this series if that 
is OK.

Andrew
