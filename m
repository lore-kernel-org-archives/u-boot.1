Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1E606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nUBJjZ4G;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Agiv7HRH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E48B80E6B;
	Mon, 23 Nov 2026 16:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifyvuyYyloJe; Mon, 23 Nov 2026 16:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2807380E5D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795450668;
	b=bXbM95hSb09fCixuvYD1b0X0Z1Mu6X276ik6F2d1pki6Q3ciaNEOTf341TcNYpvPYkxU
	 fiHVa7CaPz3IQAm3VQFnTwbPJGZSYTeSc5PdwqjMeamZp0YtThL8kDeKVzDAlB0WhyI0i
	 E3uyugQmC2TYSK1EIHwwIaO3D/1Ne9dd9QpuB9z5KGimggn1Z92bS7q2fKoHNu5vt+uUt
	 87+e4NMUqdoBC36mx6+5MIfigohU4GLw/MKwfObCgAd9DvdaDa6bxfTKwiUntLSCL3ZGC
	 oeHDrCD71V63XQgkQdJ+7pK7FdYR7l5bpiN0UeD7vVoP7HFkHsxWEC8BJq0CuUWp1ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795450668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A9pYeAXq4QVSM9Up0kEbg9psTPYl8zzsFLvvk+1MaDI=;
	b=gWcwvHfNv6Lm6tSuLbPHTVm+vUUbNLhWpFun9r97Ujvm+ZbxVfkH/4aI9gt2PPgSQRe+
	 hoaRfYTErgnFhz7iCyYfoRYI5lGNZOEcRDv6tbNGzCetxUfMaKjpQupqzp7doaC4lCbb8
	 JyqrWw8xkutKboEVnpy5e/KYZh3/LkqniWQP7cRW34WjW2w5/oMymPimEKixgIaVOw3P5
	 Fp1SVRiY39xNwmlpNLelODpVH/bpR3hF9uOG4cn7YXzwdZFv4c+5dFs9hXQnnfoHLK5lP
	 uvrX7UleLy2QVJLXaHGjlVDSRjyCOf4sSRh+blDGFRKax/YN6kd8DdZU8tA7RYZgMZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Agiv7HRH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795450668;
	bh=A9pYeAXq4QVSM9Up0kEbg9psTPYl8zzsFLvvk+1MaDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nUBJjZ4GowIBejPsa7gTQ/kHZ93R/6O5BVaeY5hwghA75WrsIAES5oTSsMf+oJn6L
	 O3r7voBNaHkNCso8dzVbQ7MQPqVX/FRV/sg7wmHsz4hPNSod7bfEpaUprWztx2gAL2
	 8noSmNkLE7JNZJTCEyeYwxPXL00InCus/QkwCAUhobWbLWZPJ6pPXVMdfqFJLqOC5y
	 wLbH6UpnfH49q3jN8rVL6EjosYp7y8UVQ47inc5kGv9i/jeztF21Y/ZjySCbotlBRF
	 pHCVVcCXomIM+b11Rd4CyzbuDXSbb0ChKYi2Vry0g4m9bdPtK3yyynHpAURO4E29UC
	 kdjV7wNnB4Hdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2807380E5D;
	Mon, 23 Nov 2026 16:17:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 36E9A15D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CBCA80E5D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BvdCR4R91L8A for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 16:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3ED6380D1D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com;
 envelope-from=robertcnelson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Agiv7HRH
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3ED6380D1D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:17:44 +0000 (UTC)
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so4841264c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795450664; x=1796055464;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A9pYeAXq4QVSM9Up0kEbg9psTPYl8zzsFLvvk+1MaDI=;
 b=Agiv7HRHsniDrkXN+M8qRRjqM+JzOllx3wc8zC3jhit4RAuPUzHTh7nAHOAmuqmqXh
 xajAJIEE+CixR5ElyrWwClFkg7hLKW/zhAbk8iTk2Fq9hEMLA+wUXYTQVuC85C96OSPp
 9vwUJd7wpQOXwXOGGm78GPQiPw6G4+973X5oH5YhgU77dunF93g/M/Gaw1MWO1nKZxe/
 I1AafkaVbc+nbHF8XXZZ1cqeKR0TpjXXzMRzZVbq6LwAHYZFjSnBTKms22Iz4U1lhb8W
 gljMhIyuU5LbXfASnCslJtnABhnWoi5o7rYbVlJFBEmkEbuZs08BiF7hWrS/vnWhiBVK
 Lcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450664; x=1796055464;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A9pYeAXq4QVSM9Up0kEbg9psTPYl8zzsFLvvk+1MaDI=;
 b=CvbTzIbUBKVFFfzPGwpt61R2vf6FiiiLJIWGGD0t8DwKHhsx/cLzeAJVPNVbXR7Vn5
 lTa6MKL6uT7/hvvSUqe3oek7oDWR6ILLKKAGcoVJphKXFFdeeWqtoNuzF0xNRgAMHJnA
 GslBIUc0DIX8/JqLWgg1XA5Z2dO7BiSlf4dr7VSQqYXkQIsqobDwNGWIlLW7kZjGW+kT
 nquiNUnaY12A2OGQocndUH7k2ktPw3MLsszCXN++SCHqTsisZvt62IlYRaAdhjn6bNfl
 VEGcVNfal6fZ9e/jgcN9Y1WW2h4/oNxPtguvGjBOcYWqBohobHM+wnHrs4W3jgZp6Rqj
 r8yQ==
X-Forwarded-Encrypted: i=1;
 AL+hErExxnM+S6yF3MVb80qbG7I/ehZ/64cFcaRPYaEAOnPMpPgkinoRdrBghPV3BWdG4qXSRhDbv3A=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8pyTBYVj90YJHcNeM6Y11CXzMx9D3nWsGjzOSyZwEEg1sXd5pw
 D/1IcqV8UqHVH9dxkLVc9Rs9nMLairPcYaP9o81ZchBPf9QVvMvviU6rovZgDVwEVykmPHJoYSX
 0mZ/49txMbfJGDUIe5qIdFhCckFCm6k8=
X-Gm-Gg: AZFdTZdcYnf9vfgIcU73N65a1Uyf3EAkvejpleDGVgXe+6J6EH9bXAMZwYsfTa2M6Rr
 1U6ASVa6UPKE8Ca+9HKI4QeBGZznPxjjsJd8aBUnz8CgiLMlUDMdWC7t6vrRDnOuaCYfwDVnHN3
 VdM4GpGbGIjrcvEGlWavhhmfLb+VuC+EvzLMDtMcJAsg7y3ebgapuJF7KR8Vj1oeazd3masCbPx
 q/HnB12knEXfFMFhbQi/AF8STjIbsZeA2Mm4DB0evawK/35vTFUc+Gy0MzwMFyGheFncwzJ3OrH
 X0dImt+w8ZDMiCYRY6xt7RyDiHgH6mjOKBVyiQZCrb0AogTfP26XtVuusVLibgi8afij4yDVVvq
 VhRBR7Z3lGsCXVdi4IjBUQr2j2Hi0M2AzDcyd+PCX3Hoc9m4Rtef2ZgMJs8bgXIfkkmwJHnHJrb
 iPUwlqtGmrXbJhkOfsq4cj4M2Umzi2XScW2ZGkpz9IVB/IIQ+B/YMBKAcUfav8V0cNEmZ/mcUio
 BSH
X-Received: by 2002:a05:7022:6985:b0:1af:16c4:d06b with SMTP id
 a92af1059eb24-1b55686d5c1mr15151370c88.10.1795450663958; Mon, 23 Nov 2026
 08:17:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
 <20261123-am67a-ethernet-boot-v1-1-94520ed74c90@valla.it>
 <df5e2301-787e-43a9-b7bf-4081b0267133@ti.com>
In-Reply-To: <df5e2301-787e-43a9-b7bf-4081b0267133@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Mon, 23 Nov 2026 10:17:16 -0600
X-Gm-Features: Aa3M54o-d5SVRbVBXXQf3h8qHPlgUAnDhYhg4mslDN_b_uYF7zJAgZs7NE-Sz84
Message-ID: <CAOCHtYgFFK80kwayuDi-bUw21_s0+7qwqUSJT0ChRu3Edd=zLw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm: dts: k3-am67a-r5: Fix DM2TIFS secproxy thread ID
To: Andrew Davis <afd@ti.com>
Cc: Francesco Valla <francesco@valla.it>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nishanth Menon <nm@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Anshul Dalal <anshuld@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 10:10=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> On 11/22/26 5:54 PM, Francesco Valla wrote:
> > The DM2TIFS secure proxy threads for the AM67A R5F are 28/29, as alread=
y
> > fixed for the J722S EVM in commit e25900438256
>
> AM67A and J722S are the same device (family name vs market segment name).
> Content of `k3-am67a-r5.dtsi` should match `k3-j722s-r5.dtsi`. I wonder
> if `k3-am67a-r5-beagley-ai.dts` should just include the latter and we
> delete the former.

I agree, best to use a shared k3-j722s-r5.dtsi over a unique k3-am67a-r5.dt=
si!

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
