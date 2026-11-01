Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFCC606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lQaPAhaS;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=hDXmMZPG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D3D6405ED;
	Sun,  1 Nov 2026 21:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P051xtVHE3lT; Sun,  1 Nov 2026 21:26:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78528405D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568392;
	b=O3fDa39FByDOwgudIqwtBdQ9OtDLh5TdBulfiLXcYxJsVjX702r+M2bslf4sAdcUGOqr
	 ++7nplgLm411jF/F6SWjNzeBO12N59wQyqICzEp89Vjo8edFh9v1b8e9BJFuktNSWAclQ
	 eyYXrv3mK90+e5XsY+TOzRGzjIlaA7VRnB1aWRrWiMVX8G1KZo2ESP68zB0n7cNcWog48
	 wiB7s4n3FdGBvwoPMhtwl2IHzYHJHMKvPIeLLafwcVDs43Z/C7FDa3wmSO6Tklpxeraa2
	 bVeduFZrcB8QOw0MexGpo/l/Np0UgjteGUzYJ0Wzdz9uKvYE+J5V+2ohx+q76ds6rVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rx4BTm9XuGWUS/1ZFa/SKwbnAo+2JHJUU1UNHzqdlMM=;
	b=h9SOJCfJ1h7cMXZDQJ3Q8csWaU5yn2WB9WsDhzt9B2nPjQS9w3pza+f8SJHmNBmJOlK3
	 KF3rz6EVzMf1mrWyNUZ6ESXB7eOB+Ue8dmoxwnk6zKQBUAVN3CmveEi6/z4o4ANGQ3WN6
	 IS1POXkTsKhXksocu7JoVmE41Fy4KhTZtOh+bl59Ti5Rq0T9xDg49UfHkvzvSsjr7WKJ+
	 42C/SUsNR6JPGElI6Bx495qg71Y+l/5c/PN5n/jBLXOBaoERXlXsWfDDxCBsUNnVO+ek0
	 q5D7vBgqiaLuBovA7xDRQlTUbGdR+zy7dUFaqrakgbBtZUC+82U5XOaw0zP/8dlY2Hg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568392;
	bh=rx4BTm9XuGWUS/1ZFa/SKwbnAo+2JHJUU1UNHzqdlMM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lQaPAhaSgrZCLxuuLygUgXpThKKRkHxBSDC+1R/aLOD3WGA7FaN/GNugdvUfuXjec
	 8DRj4JGXvqucJnmV2Rx3Fu8GxBMOMPCZ6M59xEalwnrPFyrMB5/N0oupEvVrqMQo7j
	 82qvM1VPj93eVHJKseG/OQext04P5/GlHVLeGEN9OJpE2Z1s+vdfnTjPXUarxb/emy
	 /osXm8KcTJUL5NBEEFukSjWvQwHS74hCMKJq5ZljitcVcsTBdxx0t3AE++Q+sOfvvY
	 WslogOu08SGHEFdq/s6kzZmY5/84ae0+AHhDjk61VlZj18Du9iWNPUmkoemQ9KCR/v
	 0a5GSgtj2CIJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78528405D9;
	Sun,  1 Nov 2026 21:26:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AB0634D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C9D680D97
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ur6Eqr92-9KK for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:26:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DA6780D96
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568388;
 b=UPGv+x8X0FqAJS6B8SZlVZFPFaSTjbLEFsNL5H6fH2qm4w2VbeGnDYPuaOvNr6ZiX+bU
 Wxb/cpSI2GiL0A4RWEVYJEDYgunCqxBfQys8+lFOW3Jet8omLoCZXBKgbuxgx5EO/716o
 dUGMUwT7ZsJU5/hNlJb2H0TvSJnWOO9vBgQltFqHhfaJVsMeVuyJvFYTF+Rc2nQ65Y9o7
 coWLT4862IfjDvL0Qr40ri1kyNaa277x/oieyqt/9zmRePdTQCsCxCk1z/HJdZq/hkDrB
 qFIOq+ojBNwIIoYDHEEoi79udTEla2+8s8jZLtHz5qPy6KNiii8NtQ+v0awu5Ad95uA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568388;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=rx4BTm9XuGWUS/1ZFa/SKwbnAo+2JHJUU1UNHzqdlMM=;
 b=nj9vpDFykK5W5wAkYRoxkXn9O9x05K8iZRidaeuUzKuDCmuGeesNXmfQZwjTMj66xREi
 BLzhACvrJNgfQjfX0wzZPTSBixcydyp5INQWyiMDpGVByFlhC2CTfa/M7MmQRt271SipI
 oEutTfwZtuaeEZx2KvDFN3Ce8C+rqhyj2l3ws2npgNhiO+kDBr0mmLk8OYIjoczKHiSyg
 UPh8Wjl6yFF2Lo3ea4fEFvf2QXV8cLYQoB07v2xmuPrYE7YqiaW6fYZFXBE0wwhyH4GRd
 jeEDXJcWA6V8WIbM6sryf5/1kM/fGjF17TKfnI+w4rXZp86NX939LtBIEqlUby+JQFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hDXmMZPG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=hDXmMZPG
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DA6780D96
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:28 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so3365529a34.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793568387; x=1794173187;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rx4BTm9XuGWUS/1ZFa/SKwbnAo+2JHJUU1UNHzqdlMM=;
 b=hDXmMZPGctjbkKvgADJeyq4Sf33V+SkTaORfyfVDDQoxXnfRvTsfve3E4GmYYfuFHS
 cKWk8hJvQU+LewmuBSaZ7pfs0BWAF5VVIp7Vil/KmS4VNAFSsC0F6u/aIEc3KhQJNez9
 vZdRXx5K4jl4VxO4dAK20Sq3y07HIral20nig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793568387; x=1794173187;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rx4BTm9XuGWUS/1ZFa/SKwbnAo+2JHJUU1UNHzqdlMM=;
 b=ZFO8nUVR5TPhSDSXAJASOyXlrGsWMccEfhSN+y3agEv2g/CYQNCBddhUAqbuknm6/8
 r+NrpML895Lqyr150cgJbJqh9QAfl0utdfqA7qWSopOBXMhYBt3wxU0RSR8+WuScx6Oy
 tmTjGvdbCviTQ7lrfL5hJcqgzbi1GCz/vBP6HSsgxzyYCbhUvoA+1YUkTMTTrCBFG/GV
 xTjwVEGYg8msjclzSkvHT8OwARVm6ZbtBBQgaMuF5bWHiDEiARZ/FZPUjnxDQ/YgSWVK
 cGV109rWAZsRohjL+RzzbuV8PTqnUtQgiEmxTioooX6u8SHTUvnluosxt+uAyJSCkbDN
 c7IA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGW3cag2IL3XrHYYMUEDVcHLGteMG1Lic6MGiSEAi0+rWi8805KRZiW1lbDJKbVAxvoJ4SUEM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKOnBVLfoER39K6CPA79cYnLGVQu7w/5Z3MqIxeObG4kHO412zf
 oFHGvehmtYjpk9QnS/0ydMWMHxAUyFPudF0y5bMyGlkR4+IUIEP1XHXH1tyYxRiLzwJBNwLeNrA
 8qjOGIYuVrL5W
X-Gm-Gg: AYBFou2BXey1DuGLaiVfMQsrJSL8KXLjdHuE0/PJgnQWzz4wfVQhfybI7Wplc6NqPhv
 cc79N+1keAiegMhitD4ihyNJbJRF8EE30sGfZEID4U+ViKhuSOWIwLk7Tbr/fzd/KaEeFollxnz
 rX6FA+2OvjG23IHtZf4l1rLErSJqNa0XEzELoF7o5h+esVkFz/IvLsD2/Xrowm7eZVIZHjwC//1
 PtvHfRDv/Jlun/XC33Kwr1AOnStVmtTw2ZKSe37adZyHCYgFtJSU2E8WUGbSKQPxdo359ztd1Mq
 cymefovYcLuq9QMcSsR62UJdKbLlki+ASU9WGU6Z/psxtZJijQUVr+6YLY7pdlreIP8sDf/URdA
 +JQ/xsWTvftjbXALmTD7dpu1kAMKqanf7mDQJPkWM1ZFfKERcfvVo0ES7SqIahV9atBXK+dZx3B
 xX+Wi5nIcIRHQJ9sLzURNmwhrx4uZq78bMBJAvcBGS84VxoxtFdGxBzaXvvW/b5Lbso71LqSU1h
 M7Qv7tOXA6ZNdd/7DytApUTtzp1YuWAzyW/7Vs5MbfQomDeI7McI8g13xOXtEMEZJSr+H7YVxyC
 Fqod6RHmB396ScdO8KS7q0/nHiK/rZsn2rxHvBiU4Nm0xJLpRNGKX0CxuMPf3JBjcJwJtfEOHvU
 PYOuqYcQgwH1dgRAeO8DcRgtYQUwgOIwXAVcRq749KykpFTG3AMQpFACAju0Yey8irriJCJBZ26
 AUyw7tWVA8OU07hexbK4kB72VhvfJSJg==
X-Received: by 2002:a05:6830:7181:b0:846:5201:5286 with SMTP id
 46e09a7af769-85d364d3d77mr6412185a34.12.1793568387025; 
 Sun, 01 Nov 2026 13:26:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545bfebsm7405744a34.4.2026.11.01.13.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:26:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Alexey Charkov <alchark@flipper.net>
In-Reply-To: <20261021-rtc_dual-v1-1-8cf78da56d8d@flipper.net>
References: <20261021-rtc_dual-v1-1-8cf78da56d8d@flipper.net>
Subject: Re: [PATCH] test: dm: rtc: stop both RTCs before comparing them
Message-Id: <179356838589.224230.16354987832791353579.b4-ty@konsulko.com>
Date: Sun, 01 Nov 2026 15:26:25 -0600
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

On Wed, 21 Oct 2026 15:30:09 +0400, Alexey Charkov wrote:

> Each sandbox I2C RTC emulator takes its base time from the OS when it is
> bound, and rtc_dual reads the first RTC on the live system time, then
> expects the second one, stopped on its base time one second ahead, to
> differ from that reading. When a second ticks over between binding and
> the first reading, the two match and the test fails, which happens about
> once in a thousand runs.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] test: dm: rtc: stop both RTCs before comparing them
      commit: 9f72cf6dcfff878ecf14b0370d5437ced2a69b58
-- 
Tom


