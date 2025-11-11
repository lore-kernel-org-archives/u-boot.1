Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8BACCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 20:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F6CA83FA8;
	Tue, 11 Nov 2025 21:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Np4uud1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09FA983B83; Tue, 11 Nov 2025 21:15:09 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E481483C19
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c70f7776aeso118151a34.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762892101; x=1763496901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OTfj0pp6yPK8I2XuGArwizV7JHjeK4u0vejrcD2tEA8=;
 b=Np4uud1OKNHfX0I5W4b88oWeV7ZfGq34Qqx1PIJqb0FZCbwj6HWIlsWA/Q3Yiw45V3
 HzQUbkkUefOpK5yhHBbp97PY4/nRlg9nSQSAr7UknVvZehNpyCdaFF6c8RW6qBFnyOai
 NuliaUoPlbO3u33IlqcX6O+q/+Wst1gi1eXeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762892101; x=1763496901;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OTfj0pp6yPK8I2XuGArwizV7JHjeK4u0vejrcD2tEA8=;
 b=DJ7y0OoRATafUVR4qz86KLYI95gdAhsJ7rGn5UO4Pl5SwUeOIkKtF+vgf5BT+cgSc7
 8zPiNQ86FM3kbReRWOqIddkRtdshSwVYRdPqIL9GNm7w0Tl6+puzt7ecPFsqKCgDE6v5
 kv2KtHT1O/WT4MrRbsvRa1fd2lOEi+MlEF6nVEZXITwZdQ/RjaOJjd/P+ssDrEDhwPAr
 QCj6ZWtlyJuo1fYeKL0rt3HDg44cV5ue5SD/b4Ma0OKYjrQkfPfG89cZlzoUThKmgroi
 Asx+km9ds25fv7gVbr0yNdRCQhl4jl8w6cCdyxC+Q0XvGRuqlGOyN3OMgMJSPN/EyG12
 bUZA==
X-Gm-Message-State: AOJu0YxbVeWfsriOdWEeGWQ5HiM0ATKNigEwCPbTunY6en6Xs9ZsoiI9
 1Yf+j95IzQMc1mbaSjbREWztPspuPWRoRN2EBwvklZnWHdLPRutzWvW5mp6uiSoB7IXw/wsNxv4
 /vwKewmbG5g==
X-Gm-Gg: ASbGnctE3WGHOgIbUpEZv6+y0+6kefhVd7b6NuLOkJxpj5Wk2oEhL4DWEGJph6cUX+C
 9d//6MhAHqisyYLFEsLzY54gZcJlxc9uTGfQyMe1lweln/ZEJdFiiEIOIOKCzzW5x6qj2y0GZJY
 yirC/1VZDNgjh99Sy8APLhpTvhTrlxwsaK+Gt2OUmkTdcO8U5AYlVe3ABMSfHi5Dbstoo4r1JM4
 0L/+4CPq7E9MeFGT/Hc62fFVytp+orz0bGNFiCFsom2wLFZWHr22GpFT5inQB4b1r/sWTUJC9fv
 Ubn8R8NxiS++lluOh1L18v9I2r6yz0ZTcXUqhHVgXKeu64WLnOehCjDNt8xuEEoNfhNF0Q6tIpl
 nXoc9yS3jHhyh1HIalAaJRtOcM8UbbupzlnwZCFOqPCooqNdMjyRA7v/FGjBUU1+PEMqiD9VPiG
 l8K1qmOBywxMbh3FfLs2gwnlFOs6mhA6fxt+cnXcFbvhvphF8Q
X-Google-Smtp-Source: AGHT+IFsTq/x3uWD83A59/9GPg+P9V/xxKkjoyVRTVmtL4muRQFdQRmmMyFhgZFGdXThLvC8p2VVwQ==
X-Received: by 2002:a05:6808:4fd1:b0:44d:b9d8:9b69 with SMTP id
 5614622812f47-450743f2ea9mr240672b6e.2.1762892101593; 
 Tue, 11 Nov 2025 12:15:01 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45031835261sm4197443b6e.16.2025.11.11.12.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 12:15:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251106232833.3243530-1-trini@konsulko.com>
References: <20251106232833.3243530-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab: Prefix more of the sjg lab with "sjg"
Message-Id: <176289210058.737015.586345403301872387.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 14:15:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 06 Nov 2025 17:28:32 -0600, Tom Rini wrote:

> In preparation for adding more labs to CI, prefix more of the sjg lab
> components with "sjg".
> 
> 

Applied to u-boot/master, thanks!

[1/1] Gitlab: Prefix more of the sjg lab with "sjg"
      commit: 363ef8e491798a3abad83eac087c824c93c42676
-- 
Tom


