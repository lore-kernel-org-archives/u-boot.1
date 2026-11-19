Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965A606A326
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nCRMiHIT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEB3540A37;
	Thu, 19 Nov 2026 12:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7qIQKJTmhBhY; Thu, 19 Nov 2026 12:06:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B75D2407E2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795089973;
	b=OEqwooM9OTxh6K4JNSrWDbx/1IXVEELqtWtnqxPPyOlidbN/uzyD4szhJ6pX8b03+21t
	 tLXQLSB68Y4YPdcbItY/kBkBF0S5/K4QwIgSkcOOGLKV3zwFXO78d8J8SmKDZUkx73+3D
	 9hlI0/FmyYyCqJBSX91eEbssyXLXpq/WkA5/Q7PCxfRZtj+2aoR8yaOifFru85IULiQjy
	 t66cm8OGyEIibagInI3yhpm64oKrp2Y96osHxF2j4cjCWx7OW1ieJjgt4UmThAu9ZfZGz
	 1uYctLFWtA/kE8Lm1Cab28MJxuoPaoZwu9qZTgYbiQtDLC6JTj26TbCEJEM73jv10hA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795089973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-QQ-mid:
	 X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:
	 EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RqQvAcP4UG4wvRc5Axk0JWJCjwOqcH5t9/dtIdbHxSk=;
	b=ZqZtwNPtDdqmg8EcVm9jRie+g3xgoqCQOKyQmV5XX+4PCx62otrxDu6PxQpzUP5+/8yZ
	 D6Y5a0RDsJVEug4aRDUaEk3TfLU6CuRSqP327hYH6Ypi0KsNJ3HkOdZg0srRtfWt16PW5
	 QILzEHgB3oQdl9k2jyJUQc/pIMnDi4ZAUFt2EmwzbEKR7w1UaBHWPoRyQpuqvEYQYaEZs
	 EUGk6xvDm8WCq4VpH62ShM3rGaw3HG7Wu2qiwizaQzoGJ2TZgrOk7BaaXPrD0irkCH3Uz
	 bmQLba6lPpx19YW0FunZc90M6ePEmSW3UDw2K9pdOGHUIe0ZGlf6CNtifiXEVDtf90Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795089973;
	bh=RqQvAcP4UG4wvRc5Axk0JWJCjwOqcH5t9/dtIdbHxSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nCRMiHIT21vRpeBf7ZVgBtG342nbOsRDnjm/LxP2ykRcjROtgw+LCdWqPeip5rYMA
	 aJfFrkQvnhqGDr1ai+BI95FxyMZReQsed/6gSnjWUHD4fi5rhJnUeKJ1u15Kaylwmb
	 N/gzkTOfrI6P2ApBCl7hY6U8LiUIAxnJUFKHHfc/iFtG/T8cio60zq+l6QJlTwoq0n
	 +Kh5byf7mluL4MykB/ttj4DRFn1s4PMEulULgb+qNqHKyk4A1EtkQqVMB+QxllMuIy
	 /enqhmjwDWUDuvFqNlbIBh1SYtJcVtphxfkGr0lgmhib33GUUxCN7Ckp0OMfq6mYqJ
	 29lTnEuXXitNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B75D2407E2;
	Thu, 19 Nov 2026 12:06:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18A301E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 097BC404FC
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YUSbGuBDvLJ1 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 12:06:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DBA75404D7
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=43.155.80.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBA75404D7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:06:08 +0000 (UTC)
X-QQ-mid: esmtpgz14t1795089910t4b67142f
X-QQ-Originating-IP: I3vNl3Y2YxFfgBqirLH4B+tzE1FNUKIB7Nox22gBykk=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 19 Nov 2026 20:05:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10209088857281885960
EX-QQ-RecipientCnt: 12
From: Zhouqi Jiang <luojia@rustsbi.com>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, tim609@andestech.com,
 leo.liang@sifive.com, me@ziyao.cc, sjg@chromium.org,
 alpernebiyasak@gmail.com, jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Maslowski <info@orangecms.org>
Subject: Re: [PATCH v2 3/3] riscv: Document SBI firmware support in SPL
Date: Thu, 19 Nov 2026 20:05:21 +0800
Message-ID: <2B41D9A9B2F3A92D+20261119120520.3129425-2-luojia@rustsbi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <35001dcd-3fec-48a9-8b1f-e2cc68c644b8@freeshell.de>
References: <35001dcd-3fec-48a9-8b1f-e2cc68c644b8@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NojR6Ao/DkEDIZRKP2OskZiC2pijqNa6tS01jbDTm8lnFInHsRAFtGsK
 mgNR24iR2VyZjW6yChf/Wy4kApBGbfterl1DUw9sAseqKGmdIHKTi08vPBpiIBATZnp3ZlW
 5izcbnLSnWmjL3ajKbtz6ej31WljrD/jxobr11izhLuPEpn1iUkYPJ0/SPyCKImAfcOOdtM
 2g/h5TqTTJS0oTw7WO4hHKqe2BIhJT4JMa171nPeXz37CRGAHsp+c1ItZ4quD0p+SyI+pYt
 f0DNem3QGU2wSUhbVrLN61XN9ueY8Npn14OTXSM47cV6DXPceGZVmQZpZSd8UHGIGyMnAZf
 q1k/6qaFgRmp0MkRq8ggeHg6YMxwko4swGRJyxQ0X4z/paKElQDJXXdKdSMoeIYg0UxBGBj
 xWFWEgcWk1meGTaWGXckn3dVQN2M5goqdh6Oqx+/ip2mgTYl0ivnuSy/yK0NPNCgjTg/Xh/
 +EhdDN/ljuZZdttuuiK79jwk47xkdxViCDFrzWJz0MpG/rlgEOQ30EtgO4ms9lqf/5/F2kf
 4UvbDUPVOI6hbUIQ1dFizoYD1jDqh9TBqCeL3j3AyPGF88kkxCCeN8VyEB5i/axbLWcFJSy
 WaOD0UmRD+CqtzoWv/+lZhLz2U1AYOKE4tzfhokcHxQu1xXNdekLWPTHfKAepvLwk3SdNF1
 OI2BQe+GGev8HrXd4ILnb1XQw9pXHIXoj95a75+hHaa9u+7G294Vk0PnydBYt1U4Hq+KgD4
 FZL9bEKsmzBmzV1gwiJU4okd+3Vq9x6nqqK+b/emYh6B2ol3nEuLvWa9SdY+PHiR8Z3Ji4t
 2vgC7blCxmdGar8SF4BGTMjfUL4SmSS+jdasZiNdCCx3GfZBja0QUqO0Q5k1qsEG7S/FNt6
 5fPQOfoSIwXay4HiI8UCcC4XKKaAqhqTjsO5L36HYlRSjwe/R9kqZ8wK9wj1zcBnIbS219x
 WYqfAy/RTR+b3mYCAaa0sRt8kHev2+xvUTfwKbDy8dWmJXGVphWvQbBujZk6f+gmadnFeWC
 A6mxTkPDgTwxfUSlgFBNPJc3c+rOby+w/1kAaUDTDDqvopQYKr
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E,

Thanks for the review. I'll post a v3 series with two patches covering
the SBI_V02 help text and the RISC-V firmware documentation.

> > +	  RustSBI Prototyper dynamic firmware also supports this handoff.
>
> How is 'RustSBI Prototyper' distinct from 'RustSBI'. Is this a
> registered trademark? Is it a company name?

RustSBI is the project name. RustSBI Prototyper is its SBI firmware,
built on the RustSBI runtime.
The guide now uses "RustSBI dynamic firmware" to identify the
implementation and build mode. It lists OpenSBI and RustSBI with links,
and the example uses the actual filename, rustsbi-prototyper-dynamic.bin.

> U-Boot main app build for SpacemiT K3 packages OpenSBI fw_dynamic.bin
> and so I'm not understanding this explanation you have provided.

The guide now describes OPENSBI= as a build input for packaging firmware
and explains the FW_DYNAMIC handoff in the CONFIG_SPL_OPENSBI case.
It gives the board load address requirement for firmware that needs a
fixed link address.

> > +uses ``0x1`` to disable boot prints and ``0x2`` for runtime debug prints;
>
> It could be 0x3 for both options?

Yes, 0x3 sets both OpenSBI print flags. The guide describes how SPL
passes the options and refers to the OpenSBI flags in the Kconfig help.

From your reply to the cover letter [1]:

> > Would you prefer to keep the alias or
> > use OPENSBI= for both firmware implementations?
>
> Correct, keep OPENSBI= and no additional aliases please.

I've dropped the alias patch and use OPENSBI= for both implementations.

> > The U-Boot "sbi" command identifies the implementation at runtime.
>
> Is there a common use for this that "sbi" command should be
> enabled for most users?

I used it to confirm which firmware was running after booting each
image. The existing optional command is sufficient for that check.

[1] https://lists.u-boot-project.org/pipermail/u-boot/2026-November/641123.html

Thanks,
Zhouqi
