Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7EE606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kMBytdtI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWzcKgh+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25F0A4099A;
	Fri, 23 Oct 2026 15:25:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eFFhBrPHXnFC; Fri, 23 Oct 2026 15:25:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A46C40964
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792769108;
	b=gnu6jIuFVuT7XF27NB6x4Y5qNN4aWi3bVKzGSJcNQWDxyPJ5iFpuOef9D8oXqdQ9rRgo
	 bik2YUYVuBOBj+iw3Fa119owJWzM4MXJl83oftE/hsQFP4sTl2jFNhSLOqZ6iBrvWmDM7
	 ZOM3uGjKpuATFrwe06J5Tx1OolRvqIcQS6bZiFarJURfpgMoRPUQzvZhC/JyBuat/s6v4
	 ASCDzfC5nDHws2DAkS+iRyo57TZQKm+bQCRad/9rcLe5x3JuTzaz+Q5PGDL11dB4cvjnS
	 FG3/be6RlvpNgwAou+k4VvkobdejwLSM0liLSCx5W3Jg9IFfKg5OSPLHrFzPBB/eItg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792769108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=g9QG+wEKXwdbKdv8JuJmRp/kZRrV+HA0WbSzHzhfjJA=;
	b=qilW1Uz/jiFlGWhqNnQExyhwzL+4ygbsf1BS2nyGTdUohOGk3HwXWnZ8PsT6anRX9slI
	 wgqGCuh/Blwuwm4NtxrVW76I6D094vJXjxB+mpH8iIJ4QTcYrdYJmpT7bsd4brKzauxUD
	 3LVnempRhy8ReaKbHTuTiDz/KSNGgTMM/JRXd6Hn563wbHyTgx5D4p+pakgx6a4Pnw2V4
	 RCXywMX0sczxee5Zte5aGXuGU5hD9Od92yFQSMQ5NKptp5yedsUYfNvc5REdQy86wGu/O
	 uAFEzjVOukE9RCUqh03xQI3FIRCxD5eAPfSvAOb7bICqaF7kwWVaJl+K6dNmFyPoUvw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792769108;
	bh=g9QG+wEKXwdbKdv8JuJmRp/kZRrV+HA0WbSzHzhfjJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kMBytdtIsrYrg/DR9xIoUgtjCgyqw7eJyBS1FWV/wNxpCoLuUJ7vRptB1wqAum6cc
	 pDoTWLC8tGJCGBBVWbCK9ur2nGTFI/h6YSOFxGulh5CC+xt48rw7CluqsgOdW4wPnb
	 iOMHw14MjNTqhBsuwE+/Uq9BAksTw7bbHkxIUmNlUc+70UAnQwwWHZ24m1Hzb7kD4S
	 snVxhg0hmZMjUOBw+O9HfcZIl3yyf6lMzuXM5kLuWRaa8Ch776m8Vgy8B+rABoP67o
	 Q/csFlGkn4Jy747aKyyvUiFLZL3Q1p1Q3rDKkrTK3QRVVmtqvsTX+zGNc0KvWJiS2J
	 S99bzRmK+/VNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A46C40964;
	Fri, 23 Oct 2026 15:25:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 54F4A3C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AC68606AE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:25:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7gHhl29TxM-i for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 15:25:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4AAC660697
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792769106;
 b=X6sEvUji+cG3QvjdjoEVH16tIdDyOAyIxIrculjyMyqpPn2iMn5JuHdqROf0jJg5gvqL
 pksefAg6zah2c7x5cQcayhNbmazipirDLfcOilej/h2Wx7HbF6LlTdxMOSsbylxFxHd7m
 U3yl7iMUFhTx8QPzhv0SS1KDre0mJ8bA7/tV/0dud3S6Lj2iPUfT+E5trXfzfdQeCL9nA
 sZV7h85sBmRXTvC+6m+7e9aJjSxA0PcL5kULufBPQEROEbXRz8VoDVl9fldg900pkyxUC
 47PSAj+WRv+AsppQvROqBT6cBNOq+ELEjlWX7YE0bz3qwFQR4sefuwLG1c4y+Ke0wNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792769106;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=g9QG+wEKXwdbKdv8JuJmRp/kZRrV+HA0WbSzHzhfjJA=;
 b=PxB1YIVcsollunL33BDXVf1/bbCabT8PjVhQGRNGIwmhLGlg73kcfU66VHOKFXno0O+d
 W+Gt9lZCcupdgb/A6JBD5BdWvNkA4inDRHgwBxAh1cHmNKoilkE+zLxO9dIlZHjIhnnwC
 ouobr8s8VRllnBi69xyufqzmvRTPUxKKf2NWw4O9zNcvLNWXhCvSKoGJad8Vm3eRUT9u1
 7QXsniMwkjiA25YVGj5etHLbBctBwtl6xzHzwX/rMa3XOjUcHScfnUtG5cqZSzO2VptqM
 FF1OcW0T4IgB05FDtRg/upV9uBD+XN5YP3KKDbWiQJlbWthvY/zhG99ROCFFkHVDDkA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZWzcKgh+; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ZWzcKgh+
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4AAC660697
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:25:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8851D60142;
 Fri, 23 Oct 2026 15:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CAB1F01825;
 Fri, 23 Oct 2026 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792769104;
 bh=g9QG+wEKXwdbKdv8JuJmRp/kZRrV+HA0WbSzHzhfjJA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=ZWzcKgh+rIcQSDlAYZ0NSLf7hRdPx81lqwMgQUuhTtumU0JFqk1oJ8bmtWa2PhB4l
 lCNoezKNjVrMG424r2rfnS0MK+gYHV3LPIP6082Av1UnYSWLIuZiidvAbTQ9F6Vrk3
 +wigSC3MuCiRZpYQkoJfeWMSo4uhiPt1c2P7RKz1MYvs0UUDKI2aRyOwdg7XCM0Cl6
 UTGS6HE3pzs+i5ilbuL7bGKyQbvr47rmcQL4CYmWLPX6/vd2bcWySCbTSsjRRrQvzI
 ntqIOXy2+sqpxumyCJU+fgxGxameViolByx5JhDxABvzFtSIY0XQXJdqVGUOfIs0DY
 RZiuwr1upoRzg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jan Kehren <jan.kehren@emteria.com>
In-Reply-To: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
References: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/5] avb: device lock state, root key provisioning
 and in-place verification
Message-Id: <179276910194.938021.7402046532940244676.b4-ty@b4>
Date: Fri, 23 Oct 2026 17:25:01 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, 23 Oct 2026 17:11:39 +0200, Igor Opaniuk wrote:
> This series completes the device state handling of the AVB 2.0
> implementation when the state is kept by the OP-TEE AVB TA, and fixes
> the way the Android bootmeth hands the boot images to libavb.
> 
> Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
> "avb write_pvalue_hex" provision binary persistent values such as the
> SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
> consumes, and "avb lock"/"avb unlock" set the lock state through a new
> avb_write_lock_state() helper. Until now U-Boot could only read the
> lock state, so a device backed by the TA could never leave the unlocked
> (orange) state.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/b849d6336bf6dc51f7ea65c0a945313001341249
[2/5] cmd: avb: add lock/unlock commands
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/632a4001829d57d906befb6ff77ab6735a74d79f
[3/5] avb: verify the boot images in the buffers they are booted from
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/91e8829767c4b4a1a132298f808be3d3202b60b5
[4/5] fastboot: add flashing lock/unlock/get_unlock_ability
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/04d89df5c259963f9bb339cd3804dc8d2d6eb532
[5/5] doc: android/avb2: document the root key provisioning and lock state
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/4dbadf86e2799f29c9c6043d3bcd81012a82ae47

--
Mattijs
