Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D29CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB6B260A41;
	Wed,  7 Oct 2026 22:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ttCn0r0ckdvw; Wed,  7 Oct 2026 22:16:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E49C160B88
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411401;
	b=tcRiN3iTmMfCFmQLmIkS4UNIazN2x9Y3uRrwj1u4kStAlrW1O0L1c/rqdo0EQcAGRedn
	 szSExMQfsGj81IRoxcVSGuWrvH06js9AAm5wmmaP6EdzZkSbLVkncPZhS3IUQEY5n3TR4
	 rSvMP+TLgH7/FEE4SHMJX8naeRdnIkrLp36BYQMMVUijOWthzi3sdqhgLNOOGKRtK7xtx
	 TXMAPLLIjVssJ+VlxpxhETEEjdo13TBSoyX4kK0femAf89TRCUJi3R9MpV2GYoc31Jciz
	 rLKUDLSaxXuijVjEGJk6CvkqkSOdlwV7qOA0zyZHNNDbbMtlsk2hDiLpece3bs5GSTA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wrl39O/S02hD9ksU8RmoZVcvIqkDnDqT9mH8Y8i57jw=;
	b=Wy5dksX65YKyuycIb3jjuZAwlECFpgBIEW7O2/tMyD2kar4H3xiav9pHamqDHqp167Gw
	 0zW2X14HmCYocuIR9g4Zj31iMzqN6lX8fy1yVG02BuMG546bUt8hZtFKQZBF4FTzf0KNG
	 xv93jOh/1aPqoXG7sQgF0WDEC+9v2sJs4KGuJC4BwT9/ioMHiM/wHl1YAASVClYF54DFN
	 SuhBbUzAnxj8/QWcoSVz0FHwlBxpilCxEh7KvAoO7ZC0+sgWSAteic4WThr58T8SCYHkn
	 Vq4MRuJ9gSuffDWcPqyItEKdHP/qWe2LvqNt0HtWomqFZKf+Cf9VlzgVSZSlLj8qyTA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411401;
	bh=wrl39O/S02hD9ksU8RmoZVcvIqkDnDqT9mH8Y8i57jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MS4lx8arQfbFwtOm1qPVdQF33BC17QIyVbt3ZNSJMKIcCGPmiKzVa6H8j2PC/Sbpk
	 8rJ6t7yHUpqXpeMlwUQ2vBIfwwSwvQGV97fw+EAA+Myfzkdr6KG95KZrMsDZkYxy7l
	 RUbGVnqTM8w5fTnF66iRz/fgl6NlTBGCsDP0oc5rv/3tvMbeLf33zdSH0dlPtCijD5
	 kbJ0oN8nEKHUa1LJKxjQxHjVK0kYwLK1gz9U1DeqvPyx3mr9tcRkLUipVhppSg4jkx
	 EalpVb9t5D2BIWve9S99htSLT8AIE1UBHiS8qeEfMvCgKXSygf2XRuz1pr/wlwoEU4
	 ZbfF/Hp+Tyc5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E49C160B88;
	Wed,  7 Oct 2026 22:16:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4250C22B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FCBA80ECD
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:26:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rzcP6dN5yJ_2 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 21:26:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6BB9C80ECC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791408376;
 b=mGRN3YvVVVda1sTHD4RiferwHf8L47hs6McnqF+KRU4OgP71XBlI/UrkePUcm4VLSOXh
 qM6HxS89/C2bkOh+yVr3/Br1fzw+Zswgi66mZWswrIIBYCztYodNT35Hi1lSIMjdpwGG7
 fxn0QuXYcRPMVa5C0rqm+RiFG/QXxYVHL1mfGC4u3tstbM0TdN/NeQ+AmU0weJYqFm3E+
 OEcqqmpx6Bp22nWpq3al/C5O7JWL6ucaY9pnaKqQTvL9cVe3JiDfcVHQ/8DHNqG0EZ9bi
 y5IBVAZgK9gJ2rHa5yOGDON+ZWeDKe6aA0ArXrF+6DE53Jjk+3H0EVyVJx4/OrNRjKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791408376;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=wrl39O/S02hD9ksU8RmoZVcvIqkDnDqT9mH8Y8i57jw=;
 b=oCxAjCQeBpLa4bbrfwwSgGi3UBA8wgfdNno2suPC29fWJzzfG8NUo+L6hCQeusVm2eKf
 X+896LjnDeDyafrQBULU+58j+zvnTnQpUlIwj7wo5tdWnpwc16MsPWCesJVlSfhLgnC/v
 iG4FAMfs33FA5Ye4pcj8Nhi0mArrLn2fuRn89yAwDlFXqAaeAPigytE5iI2h+s4tGPgbN
 vBO5kPXgERnvTXGvzgYHi9NTDjxAI6ZZS/i7lbfmy/8Knhji8bfqIoHxxf4xaCk6mrNrC
 7ktKj6dWWu07G5AFlrEF4p8UI2jzwtWMREZoVoOT/388WfaGY458KHMnKEkMLLl/kdw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=hnVqAc6C; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=hnVqAc6C
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BB9C80ECC
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791408357; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Hy0IyBd/oQthCLdvmGMcIM9NJnYy3MzC/VSta4re52MNUS8v0Ils69YnLBvmCBDrcsWx1OnjJlGd49sN/hW2n6u/GuQO6AFX3++OITzSAjp/DuqMxujlGqjIrVL4nOhv5ZhVExoN0kZQYeECjQa4hv5ZbWhiLz+arofZHdIdC6U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791408357;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wrl39O/S02hD9ksU8RmoZVcvIqkDnDqT9mH8Y8i57jw=; 
 b=GC9FZOpUVUIGW1ITTYAQNb19v+bjx7W6z0vctaVqznCkdJ3vmDEc9CRLLrHUAg33UdgfhWCKeFY6MMP4MQcSlpxlM7AIPScP3SQzaJCaZeDfSuhSN2zzQMxdW1wNKWe1ZMazcO+cNB5cFGdLX5IajDvplbrdPukpZA6MQimXdVI=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791408357; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=wrl39O/S02hD9ksU8RmoZVcvIqkDnDqT9mH8Y8i57jw=;
 b=hnVqAc6C+YadwmR1/jN9kumnW8SdptxrI0z733hTyPP4UrkyPgBcOQ5E58QbOz2V
 Y+gvxFv9OYa7Dw3+Zd2ESlvFqSWGVGPx/fxbau2rdU0sed1WmoMonc39ldvTeFUQOgX
 ktQyPlaEVuol6Nusv70MIfk8GcJZuXeDRrQUPF88=
Received: by smtp.zohomail.com with SMTPS id 1791408356139829.8145059745509;
 Wed, 7 Oct 2026 14:25:56 -0700 (PDT)
Date: Wed, 7 Oct 2026 21:25:39 +0000
From: Yao Zi <me@ziyao.cc>
To: Hiago De Franco <hfranco@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>
Subject: Re: [PATCH 2/3] configs: milkv_duo: enable BOOTSTD_DEFAULTS
Message-ID: <asa4007BmQagjyqQ@pie>
References: <20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com>
 <20260929-milkv-duo-bootstd-v1-2-1b75c9ad6483@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-milkv-duo-bootstd-v1-2-1b75c9ad6483@baylibre.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.389.60
X-ZohoMailClient: External
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

On Tue, Sep 29, 2026 at 07:20:32PM -0300, Hiago De Franco wrote:
> Enable CONFIG_BOOTSTD_DEFAULTS so the board can boot an extlinux.conf
> with standard boot. This sets bootcmd to "bootflow scan" and enables
> the script bootmeth, the ext4 commands and ping.
> 
> Disable CONFIG_BOOTMETH_EFI_BOOTMGR, as the Milk-V Duo 256M does. There
> is no EFI system partition to store variables, and the EFI boot manager
> fails on every boot before extlinux is tried.

EFI bootmgr works even without variables, since it scans for removable
paths as well.

I don't have strong opinions on this change. Duo is too resource
constrained for generic distributions, so it shouldn't be too surprising
not to have UEFI by default.

But if it's me, I'll be happy to keep it enabled if the storage (usually
SD-card here, and I don't think the BROM imposes a limitation) and
boot time allows.

Regards,
Yao Zi

> The rest of the diff comes from savedefconfig.
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
