Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8DCC25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 14:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AEC68864A;
	Fri, 24 May 2024 16:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BSMmlJON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114E0884C3; Fri, 24 May 2024 16:55:20 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC0E88682
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 16:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6265d48ec3so116697866b.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716562517; x=1717167317; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxRaNTp2tzUbIeuJjQcunALkWqXrUaYGvdpVfeBvEZs=;
 b=BSMmlJONlyuwWKncoU47kzCZTc6XgAnWlV520kgIrhIWXGjDxK/6nDG+cczA/Hwx4v
 yGKEsbxUX74iYjW+Jh/AhjOxqznA6LVjSRACYqzSzF6wJaOYuDxP398WBSqYhbpg4yAj
 L1gXofvxeY62vr2tElQLCfvoRC+Fjmbozvnhp6uYVRHiiPJD6g30ItWE4kmoyzM0A4VE
 D2mqt/tz8q3O6onAbhsnwB0YsfQSoK6juFM0ziQAi8BQpdNm9VfcGT6N7im/PzhPY+1L
 zk6EeJnzihbXV3JMVcwJuPAtQbtV2c/ljvSLVmLInzNtG8ofsvv4fYNW1O8Q1aA6rOue
 KyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716562517; x=1717167317;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mxRaNTp2tzUbIeuJjQcunALkWqXrUaYGvdpVfeBvEZs=;
 b=npvU7MbRBYUHqPOTsyACQEU1yVop9eHAubtBfQaxr28/H107CGvUnhWfRwXW0luaWA
 jBhhVbsVCfOxnIr/Yzkfl/0yiCXlf4szUG7CSJFPkSMfaZPAYYBgJwhc/yFy5ezlMafV
 m4AZraM3yF9MoRshOFrV/lY8IRgxU6jyMHs/HmRejBn/ADEfTQsc3pd3K115ilRN0X8E
 4rq/clxI4UTUDSVgEI4ye27ItNtwg8Hguw0tgznBDQI4Uy2KaJFwccwuqrVXHpfxpNCd
 ANtUrpU08Yj7ePYy7dvxwRe7uXZCDLfkkkU+q4JExr/XVTfN4Elua6y9prxHaZicv37U
 4wzQ==
X-Gm-Message-State: AOJu0YylJGH+J/44lAHyVgu0e6AijpwFlD5hYEH0jU7jXMmaIgOQWS+e
 jr4taiF/wqOaIBtxD+2019MPLw6Mt20vN3vbiX4UvTnSJGq2tu/RjaxmDbxhkvo=
X-Google-Smtp-Source: AGHT+IEm3UKjBzTdOmQxLrJ/o99sK6uF+FZwAEBVUCWtfZMcMtPz04TT7JOqvR7r2HiJGp8Sz+Y1hQ==
X-Received: by 2002:a17:906:fcd9:b0:a59:a9c0:57ed with SMTP id
 a640c23a62f3a-a6265011264mr174314666b.68.1716562517028; 
 Fri, 24 May 2024 07:55:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4db2:46ef:25c5:9c4c?
 ([2a01:e0a:3cb:7bb0:4db2:46ef:25c5:9c4c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c81819dsm142409166b.26.2024.05.24.07.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:55:16 -0700 (PDT)
Message-ID: <60c3fcd8-0944-4fd3-8a28-eba6728438b8@linaro.org>
Date: Fri, 24 May 2024 16:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] net-lwip: import lwIP library under lib/lwip
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <3b93c2b7f753633fb27864a2667d022848b2ff28.1716393035.git.jerome.forissier@linaro.org>
 <20240523150239.GN2568172@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240523150239.GN2568172@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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



On 5/23/24 17:02, Tom Rini wrote:
> On Wed, May 22, 2024 at 06:00:02PM +0200, Jerome Forissier wrote:
> 
>> Import the Lightweight IP (lwIP) library as lib/lwip. The code is built
>> when CONFIG_NET_LWIP=y.
>>
>> The lwIP code was imported with the following commands:
>>
>>  (cd /tmp && git clone https://git.savannah.gnu.org/git/lwip.git -b STABLE-2_2_0_RELEASE)
>>  mkdir -p lib/lwip
>>  cp -R /tmp/lwip/src/{api,core,include} lib/lwip/
>>  mkdir -p lib/lwip/netif && cp /tmp/lwip/src/netif/ethernet.c lib/lwip/netif/
>>  mkdir -p lib/lwip/apps/tftp && cp /tmp/lwip/src/apps/tftp/tftp.c lib/lwip/apps/tftp/
>>  mkdir -p lib/lwip/apps/http && cp /tmp/lwip/src/apps/http/http_client.c lib/lwip/apps/http/
>>
>> The list of object files added to lib/liwip/Makefile was given by:
>>
>>  (cd lib/lwip && find . -name \*.c | sort | sed 's@\./@\t@' | sed 's/\.c$/.o \\/') >>lib/liwip/Makefile
>>
>> These files are adaptation layers written specially for U-Boot:
>>
>>   lib/lwip/u-boot/arch/cc.h
>>   lib/lwip/u-boot/arch/sys_arch.h (empty)
>>   lib/lwip/u-boot/limits.h (empty)
>>   lib/lwip/u-boot/lwipopts.h
>>
>> They were initially contributed by Maxim in a previous RFC patch series.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
>> Cc: Maxim Uvarov <muvarov@gmail.com>
> 
> As I believe I've said before, this needs to be a subtree moving
> forward.
> 

Done in upcoming v2. TBH I don't quite like it because (1) it introduces a merge
commit, (2) interactive rebase becomes difficult (I had to pass --rebase-merges
or the rebase will fail), and (3) I found no way to record the command I
used in the patch description. FYI the command was:
 git subtree add --squash --prefix lib/lwip/lwip \
    https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE

Thanks,
-- 
Jerome

