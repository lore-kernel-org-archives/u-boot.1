Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA7606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c1V349M8;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=W70J31XQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF76660AA5;
	Fri, 30 Oct 2026 06:54:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ghz1qf-8YJf; Fri, 30 Oct 2026 06:54:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 020BB60AA0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793343287;
	b=V8WS2d0YDU1323q15pX7jxA2qijJzA0SE5qRZOl1m3JvQgn3LIkcduZ1H43Cd+QN0IDq
	 6ET6j2TvvBhIeAMmH+MG9W5HIjqHFW1u1DD3QrBjGnPyWa1KIFrdXgupWFrE2u2LfLAdO
	 kn3FZMGoy221i+dXG5bf2/wTy98VBttwcZyTg5RHD8Jaqkx8zvIjd6jg9jrJvBj+u5o4o
	 RIs89TZT2Rwta4lSMm/BdbYavHrycniG6P2/ytmbLlXunbzIrVJAU+f8/c29BszgHuIOP
	 2Q8ShBFiG/KBKfSzA57YZ8B9c4UsPUJxsvAYt8+vfXvDJEXNI0LYwBdV9BJ7B3kTsow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793343287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0VNvpfTq3ClotFolUAiCl6nwyNwN1APWOjvzDppDMOY=;
	b=YD5aiGR03CWVPDIYoAb6ndyKJmP5tiz/HwtuJKT3fyW8tEYk+M0EQnNZLvO1LOUqd59e
	 SlBj7SAOl2z38QCbXp9qcypOQjfFkjcNGyY+McBoj858mjXqVDHhFYTRCAEpPaQ6YtnFz
	 tT9CoVhopvMMJbDafRDvJV2YdM0grLcpr9bYXckKrs5YWgGB+Ubc0kpiiUc76Ha+uPih8
	 iR7cBEqDGrCmSMBb6JRCM/xBZMVIOsE4uePvv+VPrS08UKjQ4FMhSzbm+c/5jtj1DDLdS
	 1F07uOt8NewWLudsX0tPqg74JwinOuMtG6VrCX6BHpT5jHVWl9ee1X4+QPPCwm21r1w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793343287;
	bh=0VNvpfTq3ClotFolUAiCl6nwyNwN1APWOjvzDppDMOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c1V349M8FK/Sv15ZmcXkSeo1QnmBWw32BUVsYK5mMqHF46VaMu8JhQ2uraLiHOReC
	 atsqRuGasLdHRk5eAEJuWsxl6eoYAn2WQ82POLZXomGttgdbzWrSGgj1AdxNOnQuIY
	 UFvt4iw5E2ST4H/ohO6rj9l82FNm4edMCqMSEL0AxJgBUjZXJGZcjiD2RU0EfryDJG
	 gmAubHfsiLWTDDhQmbQkqKhaq26ST7zVO9kVYouhv2PG69y8ftJSNvMKggJZ75haAE
	 p9nNKJeH0nQH+sEJo6cFbPnbsG4XyBu5UGbRRGrALY53iNoDTigt2r8k3Ml/kdMZir
	 qBD0k69/KHSeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 020BB60AA0;
	Fri, 30 Oct 2026 06:54:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20F60712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06AB381095
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:54:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fbRcQtcRJzus for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:54:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F26AB80FB4
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793343285;
 b=BgQLhAKs19AcFgA0ZTnixAehOvhMFYK8fsmYfBarbS4ihGySxzWRXS0AAffNFSb7uTcr
 nbbpj2aTcKZE3y42RQ9loI4S594MOyb+BiLEDoCQiczlp7OykuStuu9YYnVowBIHY7igt
 h058v3SusBn3HAaZzowb9IJwAN2kh+m+/D4y+COYGxwZREYY200QShhN7A31aXBGEC7OK
 nfWQo9EBgJ8f9DP2KEfnWgEEy+EcvgDEaEJvWB6Wy8N7NK7J8kozrJkJ8nHlyLZ6WSIEL
 6ypcEGRzwM+ZRUF/cw+d+ZYunUUbDFEX6Y6IqVGZ9Cs/XEPBiCOSqbpsZnAR+Mr+e3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793343285;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=0VNvpfTq3ClotFolUAiCl6nwyNwN1APWOjvzDppDMOY=;
 b=cqr3r386uhTKJHuVXuZsy8pDKVBwfKsbAR6WFbDp0izt7/+tPbT1MTWj3X/gOiQyvurN
 xgJFXsYjPMNjjzu/DYB0Y0FPDT4muVqQHea2MqfT/iYMelO0SKbEuVgdVa3vr0hkVsvKG
 bxaMR4m6y90K/erFjHkv2wZ51L7kT0D8TmKk8b7vuTGGGsWeo4Gd/gmWzNFOjQwZesGrq
 9ftbevYpL/eSWxurXcYBqgt1KVl4QG6BGaAJMB/bOc/Rh9oXTWchR79BN3eVD5H5iJEKE
 5snSO2vZqoXACOdGKuxbSrM0PZa2ccq12HMbqRpp8mSwYaKgyaYcB4IO0bqhiJrciqQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=W70J31XQ; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=W70J31XQ
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F26AB80FB4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:54:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6C27610BF12; Fri, 30 Oct 2026 07:54:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793343277;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=0VNvpfTq3ClotFolUAiCl6nwyNwN1APWOjvzDppDMOY=;
 b=W70J31XQbgQxSS8yVQb6tUF+eMoDO9yeHmk4BuKYiJHSNDBu1CrK4VCSm6BVZaX6ENYrYS
 qCc3hq0PQrCaSHuoO3oHthoVAuf5e5MdYMJeuDXoQ19pV8kJRTutkDDsqVZP+hKKdmdEJG
 7MewDRlcH8oKimCKJtLqx4wGml8K3vcaBSPh3iW6lXxCNciS2iLEmH6u5kNuc+kIAdHrvk
 C6qrMGzKmkoNkBIwK9N5Y5HylyucQF/A7GBuEys8lMGQcDRsoahkzOSYEmmyNMVJjIU7Zc
 U327lhmRWvNCfIK2lWGfROuZdOvg0rWMueQpk+yfHOFqMGDSTnrzdsmgtobSxQ==
Message-ID: <4c7e7a9a-dbeb-4fc0-a43f-60562aa22249@nabladev.com>
Date: Thu, 29 Oct 2026 16:01:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Mehmet Fide <mehmet.fide@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 mehmet.fide@screeningeagle.com
References: <20261029113657.2303346-1-mehmet.fide@gmail.com>
 <3e9e6ed967dfd1634fe001531bc63f52df823381.camel@ew.tq-group.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <3e9e6ed967dfd1634fe001531bc63f52df823381.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 1:56 PM, Nora Schiffer wrote:
> On Thu, 2026-10-29 at 12:36 +0100, Mehmet Fide wrote:
>> Marek Vasut wrote:
>>> I assume that usbmisc driver could also be reused by VF610 , paging
>>> Mehmet on this topic.
>>
>> Yes, it could. On Vybrid each controller has its own usbmisc
>> ("fsl,vf610-usbmisc", usbmisc0 at 0x40034800, usbmisc1 at 0x400b4800,
>> index always 0). USBCx_CTRL has PWR_POL, OVER_CUR_POL and OVER_CUR_DIS
>> at bits 9, 8 and 7, the same as UCTRL on i.MX6, so the over-current and
>> power polarity code can be shared. ehci-vf sets OVER_CUR_POL and
>> OVER_CUR_DIS in that register directly today.
>>
>> On the !DM_USB question: patch 3/9 of the ehci-vf v9 series removes the
>> !DM_USB path, so VF610 would only need the DM driver.
>>
>> Once the driver is in, I can switch ehci-vf over to it and test it on
>> the Colibri VF50 and VF61.
> 
> It would be nice if we could get rid of !DM_USB in ehci-mx6 as well. I may have
> missed a few, but I think the following are all defconfigs with
> 'CONFIG_USB_EHCI_MX[67]=y' and 'CONFIG_SPL_DM_USB is not set':
> 
> imx6dl_mamoj_defconfig
> imx8mp_data_modul_edm_sbc_defconfig
> imx8mn_ddr4_evk_defconfig
> imx8mp_dhcom_drc02_defconfig
> imx8mp_dhcom_pdk2_defconfig
> imx8mp_dhcom_pdk3_defconfig
> imx8mp_dhcom_picoitx_defconfig
> imxrt1050-evk_defconfig
> imxrt1050-evk_fspi_defconfig
> kontron-osm-s-mx8mp_defconfig
> kp_imx6q_tpc_defconfig
> 
> I can propose a patch to drop the !DM_USB code, but out of these the
> imx8mn_ddr4_evk is the only one I have here for testing.
I have 7 of those. Keep in mind that MX8MP is DWC3 controller and is not 
affected, MX8M{Q,M,N} is the chipidea EHCI.
