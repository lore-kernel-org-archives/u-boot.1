Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DF2606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=McQAxx+s;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vvHfcvkM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D80EF406FC;
	Mon,  9 Nov 2026 22:20:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jz0Um6uJSYaM; Mon,  9 Nov 2026 22:20:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C85F4074C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794262846;
	b=GHOUfcJIDKMtG8YM9T2oIOsztdy8gluOV3FKuW8TebjlLBAbRPz7Sw/T45vCpXsMSE1j
	 aVZaSkB3y1PLlR/WWFyx2NzjSWRjwUZg5aOHM7wWWQ6ypfhJyXhRO2NUXkEu00OitwzGS
	 RR3CBhjzSq73ApVPSjzzpePTwhmxy3XyjG/kISUeEW1oQloRSJ/04482uX8dIR3nQN9Qk
	 3PfLWhDuZ4/zp6rWEYgmBd+rdm0I95YHXegeCgLcyaCQTHATqRfCwalVdcaQtbJ/qTlGR
	 ePaVfoaB+moAeooxDHElZ+j+4RgrwUHHzOI3bC6nTOb3RF1ujxnLNtBpIR38k20IdwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794262846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YS8FsSQuj0WmDbk10LfqbGQFeOhA0aoDSKchnEVbaNU=;
	b=MXbwPmjrTmxVXvUwKaWoykGteWaHJAAbrXu3uLnfGkLAQNg7Pw7m4BhfYfltu7N2IYyl
	 /sqWE/zU9ChQMAvhXEgkANizX8sAwNUEhXsAstNcCdG6hzauF45keBm36DQYSPoQQg59Q
	 lTlKcpvggAJsgOkfX5LpiWwXAXs9RmYFkLWobjmupntoleelerrGVGPg4f3t1mzBlVo9Z
	 Oaq+zYCQ5T0ahtEhYMBhOW33Y5aJYC38kryrJXAOXq9Ejxy01Z7ikVsFAEVQZpjpMeOc+
	 jv8IkCtZ/px8o6QudpJOa9t5122X16MlQlu8La9Iq62zHyIpRoKBkmJD5oOJXoKFclA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794262846;
	bh=YS8FsSQuj0WmDbk10LfqbGQFeOhA0aoDSKchnEVbaNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=McQAxx+sE/x29ScCRcloaHRJND8h6W+msonny9Yd24+ghVrJa9hq2YghaNhcN4RFZ
	 q6abKf4V8xymIBMktN1cONuo5Wh9d8tQ4h8RFEgjgAG7VzHmz3g/Mjke2PJuiMoreH
	 AVm0IajZLHvsXxSNHLPbB/OBrOzy02NNqk37/VPRM5Xot2lUODdZh7c1+7YX59Ns5Q
	 FjTI6VeSm7RdtibBkB29Ie3ATUcHnbbjabeOTSkzB71q9kEogtBTfBpJII4nz754EI
	 KZ7aioES44lN7ZEqTamksfv2nMwFQuTceY74nLIjk06MWpOr1RshgoJCQyUPN8FxY1
	 AizhL0xGiM/DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C85F4074C;
	Mon,  9 Nov 2026 22:20:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DCC4335
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0365B80FA4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:20:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lMtL5Sgsu4ru for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 22:20:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 032C480DB9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=vvHfcvkM
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 032C480DB9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:20:42 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so8208875e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794262841; x=1794867641;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YS8FsSQuj0WmDbk10LfqbGQFeOhA0aoDSKchnEVbaNU=;
 b=vvHfcvkME0p28t78m4Ok/nlzdtB6yypbH93VAOF5GC8kLY9WdAXDt6M44VfDA7feeD
 u/TLRmlcBJET17OqyPd65IoWP/bANYSumGWKFWIRy2WfNwNDKVaHZm5K5qcwULrQV/x0
 3tlN7qJ1FhNXRwxeYg9FmCjhDE4q6FIJx8EEGyT/CmnVZmG+vZJkjcx0GX6CsqTlULz6
 p2vNGnTBWF61u9ZCM2B0dEodZN+SubDNY7W/eiF4EYx0aywiwz7vj7wQu+inxEdIop1s
 8qC58oujcj3zakBCrDzv9b2hRqdk3RdRiv7zRf3yGPF7cAxp0TmrPFbibdHFlfFqenTF
 RJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794262841; x=1794867641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YS8FsSQuj0WmDbk10LfqbGQFeOhA0aoDSKchnEVbaNU=;
 b=xhmbiRLwtbg09/aj2HNFlr2AOsjzWZMDBxSmQw8bK0/xzA7Szb2BkGhsO7L1iyn3za
 kO6IFCyXccA4ZTD25B9QP2jWCSuee62EhzaB5jBLgOlpGwT5cSG2F2qaZMvWcYJaKOWm
 Enf+JVPqhryT5jdRJ9BuY8KDqVmWZQOgcCLI2Xg/bV3f01duixo2w5aUA9WcF6rwbqTE
 GzzFG3HsU4qEVBVmA5De3xNo3+f5HzYBg9S0nFtcAggGK5z30U6Ooy7zfsaQgrxSoQ9j
 HkzmrTyItZMj+mjRglpuM+2CIs5JEzeHhV3yaQ9FIC3wVBDURVqXPTiUHyCmocKCG5HE
 7Rag==
X-Forwarded-Encrypted: i=1;
 AL+hErEheEnm0nW8Cz04wcOhsuenaVjgojfR/jqAoc3Gemig+iisxZ08DIt/nctm1Ilf8flSpbzKc74=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/tgNKr89BuCuSFGzdCVxz5xzdIlJ6jWHvx98k6obnSkPpGBpBR
 U8QKZYg2cCyhOVecqigG0HL4vc0+5jDGCXmWEVbNtVSdnbKYR4kCccDn
X-Gm-Gg: AYBFou2jfrC7JLNhuk8x0e7vD0Q7engsV9zcMsfySUXX5TLm3vZZX8ul7fYUDI1PP7s
 EfeBVR1iEcVR475HG000SllcrcsiCDbdJgPb/TBABF5NLrv5cu7WcGSME1P3pl42VYdsaGVAkj8
 ulSZPivHA4pT53fuoyOSel+NtDDSOarrJtPUNI/eZxHU9CxiqcmKp4afLp8Z3Utw4yMjhT8gFOm
 gBMNxii87myqx4hRqSuZGwBWlRk9ujd0C2tojMI2U0x1cpLMK+uos8vjLcGCmvNeLztP6BXdxMn
 51fbz5evYcIXwPmDLsyuqMLO2EUp3SnQrNvq5H0Yp098L1rhcK04R7DhxsEl2WEWmc25w0Rmb6C
 Z5f34eVSWTlS+EpKxDFgBApKcXM8sPS+frRdKbBuNr+f7MhFD0/biYvsSIct+rXBEkKf0LCvOhZ
 hjjTQeJUDS9Gf0zE+0/T9SZCgRks6U7UuSYaJUC5LsfxlYyrV/Zpd/wmtCm3rePzoa+OnJTqqvW
 Ez2pGtuwvqI5QE7DlMj3LyF75ROFJynt2QvH7GqBGqJbzd4n7CBowJWM/t3HgFcL0UEiKpU7rWN
 OwaukdwaAtJsTmigEMo1AGLYXNjwIYn7OVv21q8plzTqvE9T6EcVRESkHBUha0LP5k0ZJzAPTpP
 6fbmIhnwklRszcZXW3acu45mg9wI7diqFuM23v1rKnJVX7yQ6ekytPtvav4RFPwyFW/VdGUdNuJ
 V9HwmZaganXUt7P7x/KgfKsvwSe/+k2RQOm0//pgippZTmeflOXlvgbSIdbzQUdWls3s7Q0R4UA
 Pk=
X-Received: by 2002:a05:600c:3e8f:b0:4a1:e00b:a0ea with SMTP id
 5b1f17b1804b1-4ba023054bamr9287665e9.1.1794262840536; 
 Mon, 09 Nov 2026 14:20:40 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-757f-6ae5-a6fe-9693.ipv6.o2.cz.
 [2a00:1028:8388:a84e:757f:6ae5:a6fe:9693])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0237204csm11163455e9.4.2026.11.09.14.20.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 14:20:39 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Bradley Morgan <brads@mainlining.org>, u-boot@lists.u-boot-project.org,
 trini@konsulko.com, kabel@kernel.org, marek.mojik@nic.cz, peng.fan@nxp.com,
 priyanka.jain@nxp.com, qiang.zhao@nxp.com, Shengzhou.Liu@nxp.com,
 chleroy@kernel.org, christophe.leroy@csgroup.eu, mario.six@gdsys.cc,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 hs@nabladev.com, holger.brunck@hitachienergy.com, sjg@chromium.org
Subject: Re: [PATCH v2 04/14] powerpc: lib: Add 64-bit division to the private
 libgcc
Date: Mon,  9 Nov 2026 23:20:37 +0100
Message-ID: <20261109222037.73759-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <3CB2A762-EDFD-4258-A4C4-73082EBF4DAB@mainlining.org>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
 <20261018083516.49229-5-pepe.schlehofer@gmail.com>
 <3CB2A762-EDFD-4258-A4C4-73082EBF4DAB@mainlining.org>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bradley,

thanks for the review, and apologies for the delayed reply.

> What's your source? Maybe cite it?

The implementation is based on __div64_32() from U-Boot's lib/div64.c,
and the copyright notices are taken from the same file. The comment
above them already mentions the source, but I'll make the attribution
more explicit.

> Could we clarify that better?

Sure. That comment also comes from lib/div64.c. The algorithm first
divides the high 32-bit word, so this step is only valid when the
divisor fits into 32 bits.

Regarding 03/14, I don't think a separate MAINTAINERS entry is needed.
Your POWERPC entry already covers arch/powerpc/.

I can send a v3 with these two updates and the tags I've collected, or
you can make the changes when applying the series. Either works for me.

Best,
Josef
