Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2418CA5FC4
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EB6260B5A;
	Wed, 30 Sep 2026 17:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwgxCjPi4-fC; Wed, 30 Sep 2026 17:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8355660B8D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790788665;
	b=C0ecaFxlsGQB1ynqJ2sPpQegx3eVNSmrsWNqFKK/QaFuYxp36m6hbdj1C2Fz7m2voe/+
	 sRfJezQ58+D6o2Tk431QK+oZlzB8Iz6rS1aJ9GVQj7STGfMH5SS+4axCEwJ7KEuZAqO0V
	 zCX07eNZKp7I67J5XavlF5IPanijiJHL9+n35xBewD8BVJnBLuoIVUs564fLqW5c4+qsj
	 7tG5ZtwHmLbOi8a2kaguEd7s0diCowbeK0eaMIitJiiZteNQ+Jhn8zBLAw1oL/F/T6wrb
	 xM8Qrs0UdafxR3MQA450v6IUdDcfAIp4iN7Ft+/626wFstFv+eareFlKD5vzEG/ZDTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790788665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Xf/qUWuWLy5U0ZwbiSjKe6qsPzkFsS9oBm2+fKFy+Uw=;
	b=lHrKIOS1FZJdyobHplHj0aYBK2Z2mg5bioJ6C6Nfc6il+4qbOuSufuBH5hpf5Kh9xeP/
	 WheZJtBf4MiA9yNDFQKTJAcCdPqxpvTt3orO+XX7uBYiyOOdIkF3CjU/fz/iqLHMWltEJ
	 /bzvGv9kpHkViqIW/K/fQxMbSRmIOCwA+ucE+nFwL+fMr4dObrv1rr6am3Q7r14UwkWOB
	 dtdvXmdgpqPHe1rlwZFqMCtGD7SGzUktI21++Gm2AKoLY3jOqgCQSlNn1UiBQCR1W2GI4
	 cgKDfqyXo0zZnopTmQdXI/lLiPOt6O2GcjXqQNWpuS5Yzuwlqi5/uxhmzT+NwjHOtaA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790788665;
	bh=Xf/qUWuWLy5U0ZwbiSjKe6qsPzkFsS9oBm2+fKFy+Uw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h5t+ITpPMAB4VXW9kD/xy/CNSWdSeJbRYmnoS5VxgQNosg9Ic2ryGwPAMw1Q3Iw2x
	 0eE/fGGWePvZyfkTz0GoIiR5fe9q9GNbAkuDEx1TkgS9ATfFB0WiGEaaH1C1tch1dB
	 CWPXjckhyrBHssSNkZNT3I/4Zh2+Hd9ty9yWi1X0HIzb9Qh69KVyALxtNJimfWzxPH
	 8oIp+Zx2ZgXeSxJBXTfocpgWWVXnerl1YN4JIJZMHQO7Az7wVytVLkPBf12GQeinau
	 lUEPRZr6kWJTBW1yAu8hohJKdOus8WXITYecD6vnnzhtfK4cpdbUcVKSQRLgd1mfNP
	 zk1lT8lpqeyhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8355660B8D;
	Wed, 30 Sep 2026 17:17:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 402784C2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E85480D45
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2u_Vj5aZbEIr for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:17:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5618680D32
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::27"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790788654;
 b=U+a0fmaxGFljGWqIsS2caLzTawqiZp/uzclkUIXi0FjH6Q3hxRN1Shv/eE8Sj4Ni63ik
 cTaLtp2BOjtu8RWQUHJ15Kt9A1YY63JmkLpoxEmFZs7/n1M0Cq03FudZmXeHoQrW+5C6b
 PAaNQgnGBVgvMDtqOQJgoQaemdjpH3PrT05EHtE3zKpu6ANy9tILWCPCRm3upJxHicgUj
 gc9VNkYwTza7LMZnbyKFLiF1cKGsPOVLoN7dosCaaDCoy4YjO/O0yXD+3DZ+loGXjCYfV
 g1nskuOu550hD7/AZLnzSbJ+8kEgOyizg4ql66VgAMmZPGw0b7xEuJeI5XR40b01zfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790788654;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Xf/qUWuWLy5U0ZwbiSjKe6qsPzkFsS9oBm2+fKFy+Uw=;
 b=fsYAKT7z1lUPWrHKa8uE48WNOyO8IO5U8pZCxY4vqhtOR17ohJ6xO2zLvLXPqZoHEp/X
 wLfHW2T4DaORWizUfg9BjsSlWBp8okCMk8XBdyaIa5t599VMdLeH81P+GZiXPMWi19hJl
 3ySmTmoi75og35Enzn7d9ORbzKMuLL/nBRjYE+u+FgwH5vZJS1uveJMgiXullknuxj4oE
 lK5l8o2Amu1hU8QNQKAeZEn/I1Tga09M9zLmunGljVueP+tV/vogvrZW6ap/WQpmTTgDK
 pbfan8+BbARAv6XL+NBYJG4J0uf/cKy3S84T2zq3ymkuEm29kmWCV49E1sElLumWVmA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bAwsmEbK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::27"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::27; helo=mail-oo2-x27.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=bAwsmEbK
Received: from mail-oo2-x27.google.com (mail-oo2-x27.google.com
 [IPv6:2607:f8b0:4864:31::27])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5618680D32
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:33 +0000 (UTC)
Received: by mail-oo2-x27.google.com with SMTP id
 006d021491bc7-6dd7916ae34so226928eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790788653; x=1791393453;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xf/qUWuWLy5U0ZwbiSjKe6qsPzkFsS9oBm2+fKFy+Uw=;
 b=bAwsmEbKCy5+rfEDYiZJu9fLB6ZQxQLr72GJvnZj4TrA6PhEj8roA02BsNJQqZVGcN
 i4k6RVf+iKA838Dn0z/vj/FdeeXoiibblpuRvkcGzN/FVdMKIu6anCi2fWSOI7HcjpRb
 LLhdFtyfSp9MiZ31lHB5oJQLcN61XQqXjA8J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788653; x=1791393453;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xf/qUWuWLy5U0ZwbiSjKe6qsPzkFsS9oBm2+fKFy+Uw=;
 b=XzZaDwQdvXJvpTlBcH42XaaQxfTFRKIvPjHvG+rn/DqDCvWZdOdvoT8Sj5XkU5vQLH
 5iYtcA4NgbFcCBP72WOPNtUPInFKDNNAdcF1DOlky7UrJrB7ApBaqZBSg0Jxi+Xg6LAC
 ryL3ikTayW7FyfgB9GuZUIYQ3Ebwlny4hyMGjE+NMw/xpyktzYZXdkNvq2FitOcDAspl
 o7psDlgMisrI4gANbk+QtbT8IcqMLa4Hc6/CRH3FCox7tWXFmhg+SEe82VlAtULBTrCv
 CUlRB1PlBmV5+q8G2MkE2PMAsbzvUpEvni+0OErLj12GVDwi82pKXSku0m1iT4gpC/A6
 Zz8w==
X-Gm-Message-State: AFuF++mtiqqHVHPcgYcxeMeN3DMyJf26pAZS4oVtDwKYLIJWJFeGNYuJ
 fxmJvusLq8ZNcTtagEDsONRFUyW7eFDfEE/0mhCjroYZq8O8NCa9z9sEvXc/cIymnlS1gZYuAUi
 AYenvfbR41Gb5
X-Gm-Gg: AYBFou0O9uGFVXR4SlZkwwEXVcCwQ5EczByxgM+AZU/dtbfZ/EM5i82gPdsG0CseGNw
 gUtRy9k/f/z6PepiAItUKzRMFDm1xI0d6KMJnFErk+fwf2jaM1TITVrl3zOyZ3Vp/LEdVO4DSk2
 MMfJQdU+HlDDfhrtFYO88O2KqmmX7e8jawMFI3DVPbKfai039sQGeNYfKA0vtEVZr2c3BhHuJQI
 xoM379I59I7q84QJtLaWPaow6iKLkQuU+sycwpBmSORgKZqvypBAnUSZKKCOPtzsYxczZiHeWwh
 R+4OdV81K9AMfKOAk+P/Plk3Pr00N0SNcKmy+7aNQH2yzhd9q/YSx1oUVut4/cRjOMXla3zoz/p
 AUjXh/E5jcpGDa4+BXkRiU+QADR16ALAiJIqkTaZqPj2qsMduvPX+NuBEFDt0weV/DC7LtCxVK6
 +GpCilkk+X5wbJVokdnpSlQ1iXLyThEShHYJEz4BYVnED6+N8mUvz55jBxnnYtz0WHxWJdGMWRr
 6O0eJ+7w0I4p5S0lSn97lRIO+0rwEGtZHNWMAKRGxezUh6ZUUF1hV3RibA28IkBbDugCkamibXm
 azhC5uaDJ9vRd62ptQDBIurTRrI6
X-Received: by 2002:a05:6820:1906:b0:6b7:46fc:1c4 with SMTP id
 006d021491bc7-6dcf5051d12mr2065428eaf.35.1790788652773; 
 Wed, 30 Sep 2026 10:17:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd985dfee1sm591516eaf.12.2026.09.30.10.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:17:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Adam Ford <aford173@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20260913155231.84127-1-aford173@gmail.com>
References: <20260913155231.84127-1-aford173@gmail.com>
Subject: Re: [PATCH] board: logicpd: Remove AM3517 EVM support
Message-Id: <179078865215.467656.16500556944704840853.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 11:17:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, 13 Sep 2026 10:52:31 -0500, Adam Ford wrote:

> Remove the Logic PD AM3517 EVM board support along with its defconfig,
> config header, U-Boot device tree overlays and Kconfig target. The
> stale copy of am3517-evm-ui.dtsi in arch/arm/dts is dropped too, since
> the board is built from the upstream device tree.
> 
> 

Applied to u-boot/main, thanks!

[1/1] board: logicpd: Remove AM3517 EVM support
      commit: adaa1c5c2caada288baf5cd7bed0863f7f3213c5
-- 
Tom


