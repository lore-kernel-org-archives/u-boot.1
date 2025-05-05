Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7839C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 16:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB8C8213D;
	Mon,  5 May 2025 18:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K8i2XuSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3EB820E8; Mon,  5 May 2025 17:29:55 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CF2801BE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so2708549f8f.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746458993; x=1747063793; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NfGyAZ5OQlxCZlUzb7bIjSLy50+Auef0P7pWjpjt+K0=;
 b=K8i2XuShGOdRJuHJJY8iHMpVbacxEQigl/9tPBJ02t8/2USc8eBB+Yr4dyFl1f5obL
 +krb4Oswye6sNFNhLMnSecIaIOUqP6nuJqxN+eZFJDgIv4IpCXLCt65cqEQlHk8hxqLi
 0gBGcN1vQ3ibIg7HAzPeirLafcaEZTHDzHxuYbRgp1e1JA/KfOiXdN1BV/ZDrJrWGxnw
 ssviGRuAe4GCqlY7VkvdUJmmkp55EERp7gvQUsh3jQAcJUs+/viku5PkG4SBHN2DHTn7
 0cGCFREVpxD0ZtZmXulsEa4yoZZmpw2gtJw60BHU+UUqtuKjP92GVAVdOzN/bjYfQ9ia
 A2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746458993; x=1747063793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NfGyAZ5OQlxCZlUzb7bIjSLy50+Auef0P7pWjpjt+K0=;
 b=miAb0oIJpmlq1VviFKTK88JPU930q5Relf5NLL/H8nV3NoQwHnzMvB/yT1fZ3AkjFX
 4Lqn033+lQk8SjW7PPdowO26r0sEWNTN8nlir/Mu2j+SB3s73ppl0N9uosaJOd5pdxzJ
 Jqe6EELW0okmEKSN4nDM0jAx1DULfo8lBC9xRTPjzItCwc0BR1dZm+q0VUNkikIcUU8x
 KJzdDQ3txN16o8hyCo4Fsypxcd6JAAIYANDPsaB5Vl9X4zYKAoU4+abeNCCY8pMeICC6
 qtVyNh3rr6oi14tmvkP15yX84FUEXBw5B/qQjah1bPFoB9PcydCRJ7B0AbD/5fnZWEhj
 L+wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUngO+uFRZ2t3tJmWm1jCDN1oJss0vodXgDwaxbWVTFZDoWbJa17Y5j8tvnyomIKnX5Zzgr5+s=@lists.denx.de
X-Gm-Message-State: AOJu0YwRrhx7M5rVuRQXcpGuJd1ZHPL3/s+W31qEETy/9Kf/mN3mBcn3
 MG7gwZtR8BdlR7RABAJ6xnCmObNXqlNRvt3Ur23L4PK7+IYmauXh7ukvt7irW6Y=
X-Gm-Gg: ASbGnctUbt95XSIyNcPsBbL+zJcE60ocXgbgQH5DpX8gVjDIB+ceUhmLxIi0vkNwAFk
 KIOeS9A0NTubN7/mWlU9UFkXtRRUj3X/eh7z2BSdSQobWurAs7kUUDMtsyP8nQatIMG/uk0rgIR
 d6/yrsy5wH/dWPuL+cAPlJqbkXt8kvLJQt15mdtvTjC/soXJiDIy9YwhU89aZSVPFsymMFM9LO5
 74v8rYXDjNr3xdZru5zDIK/2pKSc8z4T9lAfkbU2gKIMzC1ZuLpfxDK8/EaN6qSV8w7+LqNerTs
 loS3SlEUS0aU1QZj2VWkLoxZ38wJXnVqTd2YswqbHynDCOwYocWg+EbjRGmTWnTTdfjlZ2qIOjv
 54xy2
X-Google-Smtp-Source: AGHT+IHT41/seJY2OnoMnIPNJgtoTtr7ii6OyECOWhBiqjy95R2hqTtU7FKhERzQ9ujB4P3umlwdcQ==
X-Received: by 2002:a05:6000:2586:b0:39e:db6a:4744 with SMTP id
 ffacd0b85a97d-3a09fd84aacmr5366471f8f.32.1746458992684; 
 Mon, 05 May 2025 08:29:52 -0700 (PDT)
Received: from [192.168.1.47] (60-60-142-46.pool.kielnet.net. [46.142.60.60])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7a35sm10526033f8f.43.2025.05.05.08.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 08:29:51 -0700 (PDT)
Message-ID: <d2dd5f57-ca21-4fe7-9001-0526cfa101e9@linaro.org>
Date: Mon, 5 May 2025 17:29:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, seashell11234455@gmail.com, clamor95@gmail.com,
 ycliang@andestech.com, me@samcday.com, robert.marko@sartura.hr,
 sjg@chromium.org, marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250430085428.1090801-1-quic_varada@quicinc.com>
 <20250430085428.1090801-2-quic_varada@quicinc.com>
 <9e06d089-3fd9-4161-988b-14273a2aba0e@linaro.org>
 <20250505052614.ttvitp53rnjamahc@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250505052614.ttvitp53rnjamahc@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 05 May 2025 18:13:02 +0200
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



On 5/5/25 07:26, Varadarajan Narayanan wrote:
> On Fri, May 02, 2025 at 02:32:52PM +0200, Casey Connolly wrote:
>> Hi Varadarajan,
>>
>> You have almost entirely ignored my feedback on the previous revision.
> 
> Sorry. Since you had said "For now I'm fine with this new
> sysreset-qcom.c driver", in [1], I assumed you were ok with just
> addressing the technical issues alone. Will add a new op to sysreset_ops
> and post a new version.

Ah right, yeah my wording was not super clear there, my apologies. I'm 
ok with the new driver but it should only handle the edl case, the 
existing psci driver should be used for everything else (hence why it's 
necessary to iterate over all sysreset devices first passing in the 
arguments so the new sysreset-qcom driver would be able to do it's thing 
before the generic psci driver.

Thanks and regards,>
> Thanks
> Varada
> 
> 1 - https://lore.kernel.org/u-boot/1e0e9a72-40a8-4ce3-a390-edef1d6a03d8@linaro.org/
> 
>> If there's some technical disagreement or you don't understand my feedback
>> then please let me know (in private if you prefer).
>>
>> This approach is fundamentally wrong, full of layering violations and
>> totally unsustainable (imagine if every vendor started polluting core code
>> with their custom stuff).
>>
>> These abstractions need to be improved to add this feature properly and
>> there's no getting around it.
>>
>> Kind regards,
>> Casey (she/they)
>>
> [ . . . ]

-- 
Casey (she/they)

