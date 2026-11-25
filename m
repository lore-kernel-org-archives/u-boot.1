Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A241606A327
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MkFXhojL;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=XVQzaKOl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F16760891;
	Wed, 25 Nov 2026 13:43:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wTyXGxfYMfJU; Wed, 25 Nov 2026 13:43:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 725A0605E9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795614212;
	b=WR8PmIslfk6DLq4AgZ8nOqW9BneDQAjsDIObwXMp/MgnJQ07sBkzOef5E6/gDLNl0ame
	 HRY/xGUi3pSg3Nb5TDtg/1wQ+VoYDqE1/+IBSmR0JMvaPDkAjHQa8vT4daW8NaVD9V4zl
	 T47R/PTXMCdWUv8EW1FCKrS1Mhjmlh3a16GUewr+rTmvtNA4y1ELeuLIpnZMXQtbUxGvX
	 1n1bhs5vmrAC0loD84Z/cgjCxKeZtLT8pkG8V9doFFWPHhLKA8sFNt7LG1lOYeuWPh71Z
	 SBHVb2/7+J1tjg/Fz4qUPx3LDu+2cYrZvV0F/PGcB/mlc4UCYNQeu8wYsbgiogEz6yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795614212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=A6tecSRtu38+Ghg9cUh2JeAcQoaGOKY3+8yKQ4LbPR4=;
	b=QokmNzp1Xw9ObOI4KliEkIL8LslKY9Fk0lwp8Ar1DQA9WRAjgoZahY/IRiZiVvD45cao
	 TbjrrvAC3dWVb9YinHBJUxV/iw1J7EiNZDxBW9gfRa2ZfSO1IoKnJupdgOuuMxQjhNm6E
	 9T7TzUzD0kFXHbAPGUfJtDsyKpINQGNGyP49bPKttDkbmyRvBtdFCE9aLaki94WvFvh9C
	 XBMFtH92Q/JpKwIoKumLuXEteeFlndHGpls2nd7ymhRNBKb8U5pdJpiwWScD0/yCNXLlG
	 JVs7lxGRU33dO/rv3z+v/lINGcs3N6L9G91jNBn+Bsl/IpcHLp15jeR7ZKjiHu9Se1Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795614212;
	bh=A6tecSRtu38+Ghg9cUh2JeAcQoaGOKY3+8yKQ4LbPR4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MkFXhojLSfymQFb1cNFU1uk9Ao0kCgDfMwUiQiotqPrAs50gGl3sPefl7My02MoFO
	 wPaM3GDH/2jOvOAYNzDVMqZFiV9sQKXtTM8KFDNkRqpzUvJddB2bSmxE2008KVwHd3
	 77tFApflLCp2OX/QcvtFPhdmr8rE655BcyQpBtpH2sl9kXjw0Qc27OX/w2pih/8cdp
	 NiBJhCIAnNissgwN5W3z5J1xy7/Vmb5y/ACCUxZXsd6nWMAPPQ8XJMkFHHZfss8jG9
	 ZtS7EPycX+JwzDxBIR63H802Ib1vAYuMR5WlwGosjPh9w6FdcFeQ2ZX47/Fh2EzK3E
	 Mchp0Tz7cPknw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 725A0605E9;
	Wed, 25 Nov 2026 13:43:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E45AB373
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA97E4039F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9HQnVH8XDleQ for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 13:43:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 203EB401FE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=XVQzaKOl
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 203EB401FE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:23 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4a77dcc4ca0so3065622fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 05:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795614203; x=1796219003;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A6tecSRtu38+Ghg9cUh2JeAcQoaGOKY3+8yKQ4LbPR4=;
 b=XVQzaKOl9NvFT09eJeA+QHbpF5tgoFJ7VYiOxHUEW4dDLOWwVHbduuZ3aH8YONsbhd
 3q4H6Mcz/AlagsCtmDjYL3b9Kvt4h5wOW7VQwppVgj/anuDkSbDobH9YsrTjvrqw+fAj
 SdsY11d1Z9No8HzLlLhV9P4od/DvcHgWxjqf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795614203; x=1796219003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A6tecSRtu38+Ghg9cUh2JeAcQoaGOKY3+8yKQ4LbPR4=;
 b=zMkzMPc76ThIlSu3AWakajaKPnZgFyg2bUazQBl+u9ZmRjo721WgmW+vWuEneTl2mC
 aMIUyXp233jeJCfVgrHjcv2DpbUtsBjYfgE5L8wstNx69S+6knAHHKjelSvA4Ylxhb2y
 tODlGHN/0wjLvc3BDOcA0F2HoBLTCHNGK1ix4wQi0IlhM66loxh6Lu8PTxm3DhSyos2G
 xwTfe77UwvsNJF0BSVtCO5SF397tvGVTeOOC4R4ocd/1YtH5/vIzdCDOD2HtVknsuOEp
 nMlmdwoxeyTJsJ9MzbNLbqr4ar23uBpoVp1XGHqfXEDRfAaYgcXf2LT6B14SGg3HdIeU
 slkQ==
X-Gm-Message-State: APuU4Z8YA28FPzyzJa2+EWSeUN6K3yFFAjf18GlkuTBJKN9FjD8OeMTk
 tXOFSpx+ZzZcj3D6MdwsE5nJxlHv96Jpbkqz7z8h0kn3An3WsVOo/14gOH7o3zcfOW1GzcxNsnT
 DJVayQiqOtZVE
X-Gm-Gg: AZFdTZcxPHDryg1bSR/2iEt833jtZ9MXtYqbtxV0S5GyljP49wOlWhvxNxp0MlH6Ttw
 f38jUmnqUAL5iw0I7sjVJhjjpVF67Y6tTvtXJ7A6Kt4LkyPPJ/bEYvyMsVqCf5UJsjCd4qY56TE
 h5ryCocqaVmBVuUyenCGW8Phg5J8tcc/7BGM9hfsYWiK3n50BIJSzW9xEpMQKyrgVldMdM+EE1d
 k6klg6z4lkVAx9M5183b6Pvrrfa24gS+MmWkyBcFZCKTAcPnHVSoFkiS78Vuhs5XqH4MYl+YTOK
 Qtosy2bRYdhCwM0LiOFQMuPJFe7rB1OkJCJh+VClv2IoGIkBahar0n9Fyk7A26qmVMTfSaLXiad
 +4aIbvWbdnNNzXQL53/yP6y8UeXbs2QHU49zRIzADZkMLaiq8iv0tfC6igOwkllVIN0IVws6Iln
 cgudxjmubYDTTnkHKCUFyWWQil9sBMnMVQAuoApl+8hMyV6sM2mj+5+dM173acguEI0AjJ/u2b9
 PdP5Lp0UKL1kU1GVifpBEapkTw/04+zc1ymRHhGmxiFeRrhtOU4QkB4PgmKFgvZqqhy5sTEUJyC
 bU6UvaEFGBEbKYMzleDfHpKLftga3fZ2eGp6wGejQ2zoTdNFbTC2e2xZ/nF6jPMza02415vDlvK
 mSyGH0ha+KKcoksf9zKZs2v45Dh1OR6oiMr0GDrhymb6k1VbEYerBPTaVdctYGW/zHDac2sKBk3
 cgUZwo/d5ykk42tqZ+RPr8MIU/uAkbFdJ8NW4djN32JjCzTLpdaZf5/L4=
X-Received: by 2002:a05:6871:528c:b0:494:93aa:9212 with SMTP id
 586e51a60fabf-4bc8307e858mr15736962fac.51.1795614202836; 
 Wed, 25 Nov 2026 05:43:22 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5b07d766sm16204806fac.2.2026.11.25.05.43.21
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:43:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH 1/3] Dockerfile: Make downloading toolchains more robust
Date: Wed, 25 Nov 2026 07:39:17 -0600
Message-ID: <20261125134317.2479815-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125134317.2479815-1-trini@konsulko.com>
References: <20261125134317.2479815-1-trini@konsulko.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, if we fail to download the toolchain our loop doesn't exit
and we continue the container build, with an incomplete set of tools.
Fix this by making the loop 'exit 1' specifically if there's an error,
and pass --retry-connrefused to wget so that it will retry most
failures.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index e666714f0490..ab001a4d34df 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -44,7 +44,7 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then HOSTARCH=x86_64; else HOSTARC
 	\
 	) | while read url; do \
 		# Read the URL and unpack it into /opt
-		wget -O - $url | tar -C /opt -xJ; \
+		wget --retry-connrefused -O - $url | tar -C /opt -xJ || exit 1; \
 	done
 
 # Manually install other toolchains
-- 
2.43.0

