Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6E3C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 14:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995F884A78;
	Thu,  9 Jul 2026 16:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZX8rBgxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A4F84B51; Thu,  9 Jul 2026 16:53:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBEE184A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 16:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4E34F3F8E1
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783608800;
 bh=j2RN3Hi5o+gXCWI/0WNepoVDJZCdIDIioq42KwPDYPw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ZX8rBgxY4IKW3lgE2dnexdHwd0j9gVGnV2sOjIOMB8pqGv5CcYSaE6pG4w12z9d8U
 Wrxs6LY2tDn7L7HiBWmzYzcZ1yMt7rUAe2rGiS6QAz3HMgORMCh/R7j0GnuO8O19Ae
 xZuNtBBGEdyMz54U+JSz8GUvZUUz3LpkhBzEOI2SkzffXiALAULdxvfUOaNAKKbRFb
 OUtKXoLkIuWSA7Qsge7Pd0QDhqYI7YU7NoBVdYRLRpcSluCaHsgVy1SZ5rtgAzB+rC
 w2OTJ1Yn0sAS3zA4OF/4q1RzxLzgkL3ZgfMnvmO9YlCNOXO5Xi8Sn3RdSGuPoJc5j5
 0cesLjxADSukgybU3RqmyraShRjd83wN/jZmpOEOjhhzGtVQXIFR/A40OX5hquImlI
 vJCtkstbCAsyKRiH/p4NAofuDUiRbGQX3dNamzEJKefcBmTmZcOtBHU8ziEOeC4iYX
 ucoiDKMG5mwUw0TulUx57aog9pm0Po0sGsVt61lkpYbBiRz4bwBBlwFFxrTm3m/JFk
 OKklsRPrwNsXvxUcqwy6siCfyNv3cduyfqCEOTU2U5w/r2xdClUC+YDlZd5eqDkIKP
 RMb5TvsFWQyohcVZ4S65cpZ5S8DVL220pWosjkhJzJaQ4p7mRqfgrlAsTHRCVvxgcT
 1G2S0kXqgIvlOKKA6zNsM73U=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493c47a09b5so7090925e9.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 07:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783608800; x=1784213600;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j2RN3Hi5o+gXCWI/0WNepoVDJZCdIDIioq42KwPDYPw=;
 b=Cf/NiyG0a+NJ+GBlhEdp2kKLbOU8Q3Lnd2gPWuCnnC8bnmW7N6dwykYp2Cb0GMnlTw
 IyIQAQnY83SULNIOUt14bXl9LGZiRwKvOJVrVrPlJRnIpZE0Bb076PSA2JtRgP9/IhgA
 szRRMTqRnC/emwrgxRV/VBPl4IukUU8vU/TYn6Of/385VdjC0Y5Zxr46I0lNVQTOmY/p
 l3jaJwpID7duu+hHOUxk5xKrkEVXDB5IOWVm1neOgS9pJD/ynAhkf7Zz6jhRN/B0eZhA
 RH4rwnoZStpHI3xueExJkY8fwpF+8JYJSScVNWZMpM7nAwLnDm/na8wbkASmSNQYlwXm
 m83A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWL5ezdw277cTXr6J2/MlPYdWjmFDjlFP5I++uBAZdwEh61zOPai+LlTDd3AeTy+BqGQS8FtU=@lists.denx.de
X-Gm-Message-State: AOJu0YxfMnU2s/mqQk6s8GD48hzq1QIXljKN/nKtG9shoULaO8brh9PG
 FHP9SYMLP+dU5mQQ10DyxDCXZhSBrEYFP/SYfw8bsusSMO5dCdVci7mo35Hx3iYkKiCoC7lEvS5
 qR/N7Yx0d0mC3d6GLZBB3cAf/z/OmG/vLz2RzvGMdHP6v+JmFrnj/SY90dBSzmFtRJO+2tvk=
X-Gm-Gg: AfdE7cm/WJUdIQGG16OWn+yJuDY3iL5j3x8kl02v9xx3QE9Dv31wR6yu1JKRgN5kz3Q
 z45Ivi+diu0Iju8+Ckstjb5Q2a9OzQkUnvKrEnQUd2HjNtlq4Ja2VUT28nZQbPFj0NEmV4NJOH+
 QEpVjPivcbHnZWWNnm+rtvkAvWmAZx9ESkjSVLiQRvvHlpSoinasLRztdRgJRnRu643P1viOn+Y
 smKqKr/XAuO8LWpR/Uu4iBXdfhHC3NLWOsL9QL1xiKcO/PFcTwATH90rIL2G4nYlAhEm2B3wD7h
 gICa8b34EKmSXYzlmWC49EOhMbc87M7B8trIWdR7N9/UkElcOMl2v5+s43zExveUJIGGQLJMwNI
 HVXIsvK2yIbTVln9Q9+kOIXGQzroZj9jvwO/93/t9wiXSXPxlczDhjujJ4oNAmuMYsiIgpNJvWr
 /HSvpHLVGVqglQinPQrp426iQbGMfQ4dU=
X-Received: by 2002:a05:600c:8b53:b0:493:e79e:da87 with SMTP id
 5b1f17b1804b1-493e79edc1bmr65321435e9.31.1783608799664; 
 Thu, 09 Jul 2026 07:53:19 -0700 (PDT)
X-Received: by 2002:a05:600c:8b53:b0:493:e79e:da87 with SMTP id
 5b1f17b1804b1-493e79edc1bmr65320955e9.31.1783608799255; 
 Thu, 09 Jul 2026 07:53:19 -0700 (PDT)
Received: from ?IPV6:2a02:3035:68e:1ca8:cfdc:e4b:2846:2533?
 ([2a02:3035:68e:1ca8:cfdc:e4b:2846:2533])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb73ae14sm64450265e9.11.2026.07.09.07.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 07:53:18 -0700 (PDT)
Message-ID: <efba106f-6093-4f28-a42c-e1a3433439b1@canonical.com>
Date: Thu, 9 Jul 2026 16:53:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Add support for RPMI to U-Boot
To: Michal Simek <michal.simek@amd.com>
Cc: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>, u-boot@lists.denx.de,
 Charles Perry <charles.perry@microchip.com>
References: <20260708215200.1331416-1-charles.perry@microchip.com>
 <c2c87ebf-e26b-4987-bf78-cc2508ec7ca8@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <c2c87ebf-e26b-4987-bf78-cc2508ec7ca8@amd.com>
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

On 7/9/26 15:02, Michal Simek wrote:
> 
> 
> On 7/8/26 23:51, Charles Perry wrote:
>> Hello,
>>
>> This series adds support for RISC-V Platform Management Interface 
>> (RPMI) to
>> U-Boot. RPMI is an OS-agnostic protocol for communication between an
>> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
>> goals and purpose of RPMI are similar to ARM's SCMI.
> 
>  From the first look it looks like SCMI. Why do you introducing 
> something what can be replaced by SCMI?
> And SCMI has only specific ARM transport layer but the rest is arch 
> independent.
> 
> In our case where we have Microblaze V in programmable logic I can't see 
> any reason to use RPMI for talking to the same server if I need to do it 
> from ARM side too via SCMI.
> 
> I pretty much think that there should be communication with ARM and 
> instead of creating another firmware interface talk to each other and 
> have only one which can be used across multiple architectures.
> 
> Thanks,
> Michal

Hello Michal,

The specifications for RISC-V are produced by RISC-V International. AMD 
is a strategic member. Please, join the relevant technical groups to 
collaborate on specifications.

RISC-V has defined the Supervisor Binary Interface (SBI) specification 
which is available at 
https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0/riscv-sbi.pdf.

The Message Proxy (MPXY) extension defines how communication channels 
between different parts of software can be established.

RPMI is one of the defined messaging protocols. The ratified 
specification is available at 
https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/riscv-rpmi.pdf.

Best regards

Heinrich
