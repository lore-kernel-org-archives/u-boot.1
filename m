Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FEBD6207F
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 02:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21FC388FCE;
	Wed, 20 Nov 2024 03:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02ED98961B; Wed, 20 Nov 2024 02:48:43 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABADE89622
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=hal.feng@linux.starfivetech.com
X-QQ-mid: bizesmtp83t1732067249trufhfe3
X-QQ-Originating-IP: d0mG692ZOVBDrFkctuVK/MPehvjgQEGhNppQu4OmZAc=
Received: from [192.168.125.182] ( [113.72.145.30])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 20 Nov 2024 09:47:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 114429834966086538
Message-ID: <74ACB6A5AE930F7D+5ab2283a-7675-4dc2-9656-9fd1da294a55@linux.starfivetech.com>
Date: Wed, 20 Nov 2024 09:47:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
To: Sumit Garg <sumit.garg@linaro.org>, Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 H Bell <dmoo_dv@protonmail.com>, E Shattow <lucent@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-3-hal.feng@starfivetech.com>
 <CAFA6WYOLxG68O4FYrDPt9q13dR=H3c2LcRVKhx4sRMBhy8dCTg@mail.gmail.com>
Content-Language: en-US
From: Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <CAFA6WYOLxG68O4FYrDPt9q13dR=H3c2LcRVKhx4sRMBhy8dCTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Me+wKRRrSrO/5OOlBBn98pH8C5KgbDxgUWRxoXr/VNs/s2cosnucE63O
 HHERytSz/htew2QIYYIzQbDFbeDUnM2rLAQC4oUSfFE59B3DyE2ZvHz5DGg7ap9l39XeNta
 USIx4TuEnLdYqzq44S+/YCj30zAj42UP4Tnsu+wGbrJUKnOQKwhct4IkGx97iz8ZynwdUlZ
 Jf6ccM0cpDRd7PQ71ddYR6HTUilaiBU+SSrx0+P1hHR6gwKp/tIJmJyTn2cUiM/nV/CT5Zx
 p+lE4u925rilh2kcJT5o4FXDnQGZst4fWwdhtDSEtmPJEG6kkBnDWOmo9/Ic4oN3PTWLNzU
 EcSJ4mGi7ju9feeUY9ZCAX1yOdmJwgFRd44ZcFF51fV2QzaYaUP+NPUjhJlFm47uBf5m/0b
 Y69amaWWTcBGKBZircxO1/8qtcbCAvC9X4cLnaTgpskhpsNpUyNVoPaugCpByxL+tI/64nw
 u0HLl0b2AAGbKN5MLSWBQdUqWripS/I7attnV3VA9jaFopblGiEnIWghKByMKyi0mTLd58H
 fgxKx6iY2pbLPIK4bwqtSJVOxjM4Tb4KZiAC+jV32sN4+ttxn2OI21LhuUsOmkGSh/ywgOK
 iD9wMN1LhT8T/qQnQBOTYn+EppoXu1h/Nphnrbx2Lua+GMm7hj+TXlBJ0szGLAZLORBI8q6
 ys4m3jtTmXLKnLB2QAeIa+fcjoazqAECEzDhaaGzHvOtt8PJnQ09PuEfkMR6afH73sdtuJC
 HucBKXxZ8G8IPfo1GXgEa+gxjYwRHGJppIcfirvQkenUctYfuXtKxMU80l2ONpCQqNIuLrZ
 Dr5ymgBkVU3nSCZXJ7ZzKC9P5sBHMlrupCMg8sKNKP7LuabCDZbDP/o1q1TvoZL4idA0ro6
 Td4JH7RfloFEpdY3xbFIERHI+I7uSnCUYMbPOxjnZH43lNJu29AukQn/OZBIYy/43QQHBav
 Z2NVdHIZe7ySJEA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 20 Nov 2024 03:29:43 +0100
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

On 11/19/2024 12:06 PM, Sumit Garg wrote:
> Hi,
> 
> On Tue, 19 Nov 2024 at 07:35, Hal Feng <hal.feng@starfivetech.com> wrote:
>>
>> Add u-boot features to the U-Boot device tree.
>>
> 
> For follow-up work, I would suggest minimizing U-Boot specific DT
> bits. You can either re-use what's available in upstream DT or push
> U-Boot specific changes (eg. bootph-* properties etc.) upstream.
> 
> FWIW:
> 
> Acked-by: Sumit Garg <sumit.garg@linaro.org>

Yeah, thanks for your review.

Best regards,
Hal
