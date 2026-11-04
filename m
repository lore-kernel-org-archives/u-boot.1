Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368E606D803
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dlbYsZOd;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qGzjBUuh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4720180A55;
	Wed,  4 Nov 2026 17:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wXYTP0ZtenhG; Wed,  4 Nov 2026 17:09:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7410B80875
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793812178;
	b=eVpdmFp8YguTBDz5+TlPkCZS+aC9d3qMbzg2wwCbfL3ZMf7FrkMVFCLuNoo7BOhKX7+J
	 vGJwEXLgBjxrb2SYr/oilpuTngIBnTM5NxztbzUfMujXA/ylN4rJJwEBcrY6Ha+3fVugg
	 9kaNCVWDe7ciFTKuHl44HJI9oGqQdgV0mNn8Cn7mhXD1FpOdAmGMBrZcUj88M0dNL7XZ+
	 b0n4Bh3SyPv7cH6Jvqag1vfW/rJoX8Cm1kNKz+9Wby+RFv2pVKvdP8wl5lNpeImNAX860
	 GM5TRVAHBhfneSJVLB0L1u4zSu5G/JVrgxvw0Pg57+ZvIAd8nTwbNCvudNFpps7/3YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793812178;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=L6zyBs66by4LUUsXIr/bfa4OUGbYEI4Gdtd74RQZbmI=;
	b=baQCW89ZAX3SEMzJa+0Vnv8Z6IP8ciC4hmcyCKgE44laqBN8ufIEe8W8J8TWyi/R4n5+
	 4xcC4yIAltN74yvyWkW61/uiwCfrsFFWcSDyTV4lzqcJmhM6kR7dBEwwyeWXCGTCovrUp
	 4Gk9/CVzxJeezV74i/uxEi/MU69fmpwbYF749X2JOhTt2NtgOGqRdbH/6XLtd0Kb1fE8j
	 D1Bo3GipcEe2NcKStHPVf8ECiYunySmDiuCJTFd1rSCNlhviFzjz1lm9xySOAzHg1GXZ1
	 d6hyTeVENnzSeeMUrGWXUxWkAE/ZLfXwJ1lEaRD7X77LHV6ErCMTJOs4KRVCa5cPCbg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793812178;
	bh=L6zyBs66by4LUUsXIr/bfa4OUGbYEI4Gdtd74RQZbmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dlbYsZOdQGStPTSD+dzL9cBY3oeV/bpzzsDgtV+esBwNSMmnMKLYumrIWooZ2c7YR
	 /LM0dqhyvTZ3ozb9emkvuqAexPwyvmVjjrionIZyOfyLYn2YOKHjwpLy6dScRhceT4
	 ple1x2/meb/mZcWaDdwUEJEP6UF4lLKtzx1PsPTCot87Ce5uly+oaG/BcRbGC7eRFz
	 bLXYfRnzj8TR3xmsVdPRrQ7q8qAXfrqv+QM5bef8gdde5W01oVc+sD2jHtDmuZBLWX
	 H7q3WrSyoJ0G5vEvBgrNlm3/vZMRYRV/7XjTOJ6ssXSG1wh+y7VrZF7KYW8WEZvvqP
	 nIMKJ8Ajh6BnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7410B80875;
	Wed,  4 Nov 2026 17:09:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 29401B00
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0EB36403BD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXDpUV588lWW for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 17:09:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 22E61403B3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qGzjBUuh
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22E61403B3
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:09:35 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso248886a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 09:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793812175; x=1794416975;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L6zyBs66by4LUUsXIr/bfa4OUGbYEI4Gdtd74RQZbmI=;
 b=qGzjBUuhSAOa6k7cUrM++FKo0TdwHhEvw59bX2CQGKBKmIOJ9XNejqi0qxG2eH6xRL
 7Ruv1QRLFiIzmzlUq5CligNvcX0GVlTnUoL39R2H8dLa9mJzjxrYQhJXhVNlSGT1tebo
 gBQON2nDO0/IspKgiEO/LnWNQitFLGoPDebdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793812175; x=1794416975;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L6zyBs66by4LUUsXIr/bfa4OUGbYEI4Gdtd74RQZbmI=;
 b=JZByv5vFLS4mO3Ra4UT33fcFXHBkx+IooglCDywefX0dhdiC80xhaE4qEO9htvFNx1
 EwS66NI4fEAqePyKVKtz5aYYXF6xePfGmW6wOs1IZMNtEACupApyENQVNe4ncJlJItts
 sneXi9/NZR1gazbRwpwyxj6yyGBf8/553g/7ps3C0HPXdW93vX+nC8uwDTEL7Mhon5Gq
 TCH8pY6Y4SBN8B/46ntE60KhNAUzeQuLsvMikRH9geRo3MeLPBYJLQZq0hQEsVvses/i
 8ofuQYzg7ul0VULrJslZcYebjkSB/Cv8aOFV3WrwV2NSbU6hrtLB/Y5E56oqfWMwuxNi
 R9Ig==
X-Gm-Message-State: APuU4Z+BaQtkNgGIBmPOiBaoWFHMqKO6ufq095f1BslrffjlMJG+dKVu
 4vOsPksagBAG6woXfUoRgmfFzFRzPEzLYzs2XuOm//AKRXgrGB21+9pgh2jL3CBbtgE=
X-Gm-Gg: AYBFou2TUb5VCdltgHWlz8pv6r0B7wjRDB+Ow651S+58nSCZhDYYAuS3ixXgNfdqgo4
 EvwWforav9/bEraM4MPtLakvPtxo16ubSgnMbpxKP539mVAD/HY88dcZHthFM4nAtATyRKtmvAS
 Pa7hBXStnS4UnSayFe4D3iaaO7l3sB25QRahpk1ddpC9G9xGL0/r1tLXtrux3nfNwZ2DIkc5MwC
 yj87hY4lDUBvdo/WEtHtakiQzIIcbjjSX0tPn4FNQKw7ROaeuDujPL4iMlJIlMUf7kGlfHfVtvt
 wE6sgg3vPokzxVNhpotn5NU18kT+q2dbUgjwJylc8eETXpeqDuMPViQmtwjyTEzKNZ9YiQSU5Ef
 fOZTZ7kQubMen7b8ha5ddDxVjcyyiui+9QRjTDN+gVPBtDRuJSOPkApYh84rBA1+vlew8horMPz
 qcrv9aKa7wIX8oJq9RVox4gUrXFHkG2ngXMCQxvvcxei4S3Ppay+U6A1ZQjIe8AT06I64a8VL0v
 nG/TJ8X2h5PEx9yMFC4cmwtVyuMMxnBqt9VNmtj2y70uyDMFUO6sec6z0LUU9dm3W1heGigpY4U
 f+3+TC/vbWZ4/o8O3IzCBx4XCtOg1VFTXFytigdwiO8dS3adlCFlYfEZH1lspfXoExua+9UrZWc
 BnQ/1CNYHT+t2O5wORvbzDs1JXZcQeyWpBWS6syGy/19tATdKccDIssHmXtdV4G9hZClW+mlNTu
 ZN3XO2gJXvRL8hmAP92qJ8FQBt6uNbmw==
X-Received: by 2002:a05:6830:90a:b0:816:b03e:f9dc with SMTP id
 46e09a7af769-85d364a4d10mr18499174a34.5.1793812174694; 
 Wed, 04 Nov 2026 09:09:34 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3e9fb91sm2331078a34.23.2026.11.04.09.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:09:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <leo.liang@sifive.com>
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com, 
 alan.tseng.cs@gmail.com, e@freeshell.de, randolph@andestech.com, 
 junhui.liu@pigmoral.tech, zhuxu_ran@zohomail.com, hfranco@baylibre.com, 
 DaveWK225@protonmail.com, bin.meng@processmission.com, anton@espressif.com, 
 asrinivasan@oss.tenstorrent.com
In-Reply-To: <aurB2zRSuOllUiRw@lliang-1876.localdomain>
References: <aurB2zRSuOllUiRw@lliang-1876.localdomain>
Subject: Re: [GIT PULL] u-boot-riscv/main
Message-Id: <179381217355.1147253.10496642142009871343.b4-ty@konsulko.com>
Date: Wed, 04 Nov 2026 11:09:33 -0600
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 13:25:47 +0800, Leo Liang wrote:

> The following changes since commit ab4dc5aacf957835c295b59ef2dd28281839cb20:
> 
>   Merge patch series "Misc Fixes for VGA BIOS Emulation" (2026-11-02 14:12:57 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git main
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


