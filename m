Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03049606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AIzuksM1;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UiEGTpAX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E834812E1;
	Fri, 30 Oct 2026 14:27:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AlqyPELgV6IK; Fri, 30 Oct 2026 14:27:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E33BF81287
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793370456;
	b=kdFznM8mi9OpfXGoqrRMvQe95y+urmsU85B7coLAHCS27hfdDYMuon288eVN9+sW9ZHx
	 tr8QaYxXH6V110WMjEqXZI+hyoqfPJStzq1tpqaRmxwZPc+zSfVwqfv7RhPZt7hzMk79W
	 Op0nRmB9JC5DYTcj1iN4rYj9A/gWZmTjh8Bq20Svor3AYkqrKeoJjIaPLBsiEnaWhzA3n
	 VYOU0BIUc+4qzlheUi2bkYx2tX5Fs5n1hGvzqfsQiZlfrYL2nsOHlKhmYgeLhXCYEVaB6
	 Hb7f2Gm5sjhUCKL3IdilCQSGofv+hYo6XwBbbttrkiMb3sYj64Oyf7kdLfp0qpyaz6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793370456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v4VG3ogpdkqviO77iWicHPG00VfoHJ3YohuBD8kKm6Q=;
	b=Ukwj64BXlJZDBe/aRSM+vtLvpYoJiLil1jCbZgqfT88csQmnnr0Huvon7WC9zXgx29MR
	 4bQumVNbK2Znef3vnpq90np00GVnnzXKK9YttRLqZqeAtQZO0PqeA16DjHJ1F2ub9rd9r
	 0yLarPN9j5LYwfru6rPnndFUhWR7Wz6iphSa6aQfWB8SY9aU4yBW5QqzU/nSxwQz2CYTI
	 FX4uLZvVu9NJbTvB1Qga8Mlw1IYGVRdBkXOCjhN99YOw4eUktaDS1C5YbG5PDSz22WfaN
	 aOO1un9sdeFW/dvphhsnMAF+AvgDnYSeyT41I8Sfrll2ePgsTeHE9Orywl8fIKXdA8g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793370456;
	bh=v4VG3ogpdkqviO77iWicHPG00VfoHJ3YohuBD8kKm6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AIzuksM1lBeQc0nDnp7jnalsIRpoSigPx89FHlR4PidBkz5Hyofp4JyIS7CWXZMe1
	 +ifxTg4LscwHulAEPhY+EpEJTCmkuKnhMFrhkTCYshLUld984ztiq5NW/C3dZDHioL
	 93GUzvZVIPgEA5npjAxEhzhY05FE4yULuYywJojmW6plUDk2MM2LfHYZpPCrDUvxFJ
	 7C2DCCUiTiofHotaReR/B97EYd7cZFb2DWcYzhfkpa2+WB0gnIBGEw+fNxdvZQOWqO
	 SJCpaq2cQ3NKpgLX4GZQWeoIrFg1mF+vBaL98+CPzL0PA4sDFwUGc2DY/OnyrY0gIQ
	 W4qRM6T9zHfSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E33BF81287;
	Fri, 30 Oct 2026 14:27:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 46F33D43
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39724400D5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:27:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e40-0ZqTXB2u for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:27:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BAB9A4052F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793370453;
 b=djFlhDddNvAfI0ADR9OQoa0kbP3uDI72otVq4lM1zU1Mh9r3XeLxJoyqhFp3oc00os3e
 ywXowwhO2m/cYvPdrhbgFMETzTr9JYlRtgkCui58XWfjego8bWKQ7+NIaiXR46BAjsUtr
 ZzNBbXbuoxbSDF3kyxUt95K+fP5NfXddK+PVzPaf8OawIFk5uJ3yvVv03uk7Rg2NX0234
 A5R6Cm1TZAK2eUHvE57gw7EFbOnfwyShPFBRJYFj0Jt9AyFVBPEvUcnJVCAKNxStIbni6
 3N4Ees80hAunqxjqfKunDlVvj0/kC/B6tkdv5UtGqFpJI4LsZ6qwdGG8FVQY8sd6t0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793370453;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=v4VG3ogpdkqviO77iWicHPG00VfoHJ3YohuBD8kKm6Q=;
 b=Byet3kosCPPhrwrLTq03i21hgTjmELgsVD7IhdkNs4GF2izy/ewEeQaW57pCQzYY0pEk
 +GWI5V98sHPU3NJiWdmFf3tnLBAGGbIWI35nJFCJQJInH4nFucOBq1f7aIPWsFI+A6iNt
 3Op2QtyYw1UrtR1l9FwAwOaDH6i2LCE3a/cNmYivAA+6i4MT9n+7N/viN+Grsfxii1oYm
 vLlNM7IYlT2suxU5HD+0kEez+rGTI9COa0YDis2YLsj73MXi9OdOq9hy6vaFHt7ktNEMh
 T/1g3jTvU1erWC7w8ioRJ1694XOmz0HmtbWTy5fJvjOqCUnayO90tMkKD/6OaEBjGOw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UiEGTpAX; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UiEGTpAX
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BAB9A4052F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:27:32 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so4386235e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793370450; x=1793975250;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v4VG3ogpdkqviO77iWicHPG00VfoHJ3YohuBD8kKm6Q=;
 b=UiEGTpAXFhozLXZPzIuViq2PfYBTmMFylt71Kc5d+B4MiPQn7R/mJE0F/VmQJMxDPg
 OOLdqHvaCJKN3wTMs1CVIg3N4CsTvqGNJpbDD5u/rL0GF/fkLNzhnE3tiXFyW3M3v6TU
 e+TUPkHiEpLinl5L8xaO39lCPdbCbdjrq5D/gkmg/avjmOey9DUM/S29P8X5xLLnBxtl
 9pyXHO+GP9zWr72IC4k14PuHBtCo3ay0DZgeybxSZn0SUIt0wIKPjV5V/ykxIbVSPjDV
 KX5VbIHrYtNUr0La2IQb6X21Yn9hH1xeVsudMYnBP06REzH7RVCI00YgU+KVA7gWWmD3
 2txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370450; x=1793975250;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v4VG3ogpdkqviO77iWicHPG00VfoHJ3YohuBD8kKm6Q=;
 b=tn3iqRw9pcypbnCZW5H679LMyZCFtBPJGSSxZXwv0Q3SDJ816kod8q8YFzzQ/J06SO
 LKb9tZZ1ym2TWjFNg580ec45pFABq0aKyMgxWsMgZV0VvNfojO7MiudfNM4tpzIGfzT/
 M0Djrr8X5jqVUBCSpxxQj+AHwrgt63tI2nj/hOZbR2XKFIY9LSMS2iprF2ErOT67aiJn
 aLTHYxjOghau6y40RC6//gC8mNBtW63GJhPJbx+SFPJhCIatcti7ZHOyki+thm0sCL3y
 SnQsv5SvsNqqVye2+oej5int96QEKKcuM8aZRmMaUmb8Nkc9De9hNWnmOFJjdoAiF96d
 +h/g==
X-Forwarded-Encrypted: i=1;
 AKwUvByreEsUXT5eNuqxk33ylZRqDVAbad121083QVFlcN9FrcLp7B8sTh9ZpniahhSctGCqMZ1g50A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJEC6ihtR8i6orcYO86zYvxBZvzT8Hyrnr+nh/C4pueOAbAEXfE
 68Tqy9Wba9e9/PNCdtY/9+2jOwagVpXGdpYAC+XuWZ7SDSUpEzX2cq1a+89id2nB9ZE=
X-Gm-Gg: AYBFou3KXfnu8svUnllOKXSgIXRUn6uHnzFSnykXxg4K0ZVNuaedj8Uyv66mifkicOy
 wRCFIOjVhS5K0hAGq3VJYZBO6pShyU8/Olaf3e3HFnXbaLWjoZXMdFw4nZgEJaig8eHJvNsi+9o
 BkGjjS894zfEkPxKJ/u4v/Ajf9AV06FuZJdVqBZ0CGnTq96hhlw8dvoxH91z6oW3/2M+mAO5407
 5Z2SLo3G7EGTtZ7dQdO4o0VWg+tNqvuwjM70G+UTLQmLlQAH6VR9hj+z/piXWDhiOXT1nN1WFLb
 USQYrfZfXcMUtqwThrSh4F9aglLl6Drhc91L+dcO80BmOFiNb8F2IgERdR8vBO+eC6blgMOoU/q
 Ik+zNrBagRNtExYFKUxpVcGHWNXcXTiDnCl+/waK5zz3OKx3+ZnjQmmWz4oT5Cnd0MrCphVkktw
 Ypym7oYMYbDJvknm802NahdKS7GWX+v8iNMIfSTXd+4DE2KGvb/9Y+6NRMO1dG1kdBKG2ScuyAs
 kFfkKY6nTeum0Ms0SPiYl1GT53bdAEKWW27u6uMw7cSCjTYJLA09r4bWXbuaxsRjOrEyGWN8GJU
 tbZupmavK7UNKdMVTUqyBDz/kkwRG/Kt73xkPyC6iOSuZjBEq28D1uD0fBDlMnfdgGQxrUt6dT5
 CSZGtH0Zt1B+M34wT+42FWS6nVsfqOxZiurpqb+gPI5dUdQ==
X-Received: by 2002:a05:600c:5246:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4ac1889c7bdmr54870645e9.24.1793370450251; 
 Fri, 30 Oct 2026 07:27:30 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a1dsm3447623f8f.24.2026.10.30.07.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:27:29 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:27:26 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
Subject: Re: [PATCH 1/2] arm: mediatek: mt8188: enable the caches in SPL
Message-ID: <auSoydrHDXc5A1Dd@macbook.homenet.telecomitalia.it>
References: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
 <20261030-std-upstream-mt8188-spl-caches-v1-1-b45905cb19c1@beckhoff.com>
 <auSlW_sslFXp8aVs@macbook.homenet.telecomitalia.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auSlW_sslFXp8aVs@macbook.homenet.telecomitalia.it>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 15:21:30 +0100, Carlo Caione wrote:
> On Fri, Oct 30, 2026 at 09:57:41 +0100, Steffen Dirkwinkel wrote:

[...]
> With CONFIG_CMO_BY_VA_ONLY=y, the baseline reaches the console, but
> this patch stops before BL31. SPL leaves gd->ram_base/ram_size unset, so
> VA-based cache flushing skips RAM. Could we handle this mode, or leave
> early caching disabled for it?

On a second thought, forget about this. This is very unlikely to be
an issue and I honestly caught it only by accident, so this is just
nitpicking on my side. All the other problems still stand though.

Thanks!

--
Carlo Caione
