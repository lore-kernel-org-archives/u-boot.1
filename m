Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878D1CC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 09:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F66A406D9;
	Tue, 13 Oct 2026 09:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atelsYdq5Abx; Tue, 13 Oct 2026 09:10:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7592840538
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791882645;
	b=UGni9H72Bh9gFXIqlAEQhdVDHtlXl1Iq06y9rdDlD9u00QzKlQ1iiIoMKI8PHH6SmRz1
	 z6h9AcO9/wvmDsLIsFb63sJvFi8J0gvfleNOu8SdmAQfZg3guyxjJ6qjrPxyy8l/ovUVJ
	 7fdzv+4NTcLdl4ffsQVrUAdCcWQv+ytEsk8UFS/chg+9vnRbvyq/ncWyJjlRorfxMass8
	 27kZ6tpfrvS5cGwV4ILEY5ckAv/edcBM/05Lb7BwE6rWIvGqy8P14UB1PAomqjD72WG8N
	 tZS8ycop0iyVnbcAB+PiSjJffpPe7jBLEEzw0Mcy5G6++GkIYZM1x5HT177TBcrzlsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791882645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5T42FVXX7rKbweQ2RDgwcpmfdiHoodZsDXUmc/LLalU=;
	b=Qgz0TRRhPbu5a3M5Mt/lwqIigYVPZYq5LuCS+ha9v7FfmOie3DSJcA19Ywq4sKoUvptI
	 SqYbTuz2kBGX10l4SMnL8tLqcctyX5BmVx1XYoOb6F0dz8veW+nvIoPK0LNZIatGm9BY4
	 wbr0nzLkS0D3CK76jM0/lypNENIp8S+JSYswKslxbzZgjnt8AaK3A0aiPoIcwYB8y0XwJ
	 a/fwp7/QE/9roBBQcNuL6rVtZ71hzOKo441aYIBIN2Pwq+DmCV6W6oY9EK/Cvl9VL82EM
	 Pp7VtwFTekhV+BhfxN1gWhEOYlPjN9iwD8oBYL7sSrR6gX9CohKby4ABs5S+26gmXwQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791882645;
	bh=5T42FVXX7rKbweQ2RDgwcpmfdiHoodZsDXUmc/LLalU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ca+a+PFDuK12Mg1lvhiD2MWHOsKBsSLhKuhRocYua/LfAh7RQbCIZ4ZiMzAhc+DWO
	 q6NrWWDrvNdlFrLtVqpLzR4gCY6Y05aOFIZ2D2Ejee8sHhNmcF5ZixIl3K/RTMmxaX
	 a9TxcQwFifU4m/8LCKedgZMN6UnKvfid0MrILfVEQ85rQdVAJ7+qutKG+KZIF+uyON
	 NbNykwFE/9c6iNdBtJVaJ1wYeHEsPDLivSXjWXHbKA40HeY7XZRu+Muwe6iKx9XprF
	 kpMwcgf73sUkwDHyzMdszqQ5/kg7ENUH21aA+Tn43mxEtn5REtnHt92dKm8vTQ3NuM
	 p5tWG3yiWs4rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7592840538;
	Tue, 13 Oct 2026 09:10:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9D21235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB54F80AD3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:10:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWSL1jXCLU0R for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 09:10:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1BA6C80AC4
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791882643;
 b=Ie/ftpQk5ZTomJDsl4dQk3dt2+sqtsp8LlmQ+HEjAsaa/3OWmkXfy6BDO0CQCFhfdnPy
 if+b57Tdhjbqu09CshRIpCZOHySdcoMGyGQufpSfDM1Sze8pGGP3ga5P2IWlpVCX6qaxb
 Wtvo/+kDS+8pemVaLRKKldv01X1Tgdq5DSlgYBKUOMpKOpyAKQ7rw58PYVufSmT0Lzesf
 XXkRVoVpoyPqjo65b62n+iZL1eQT4b0y0/1b1G3YNGbb7PfqRIReQixThUoyo0H0P97kv
 +Dc8uC0EavS6WLmLGwqBjjIn6p7G6zr5JIfP9vNNKMlNuAPNz6SB7e9TkuaMO2+8DzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791882643;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=5T42FVXX7rKbweQ2RDgwcpmfdiHoodZsDXUmc/LLalU=;
 b=I7YJzqpIYeaeuMtNmRjvz7cPqMz//MvKF2qaBLi9T/mVDqZJmCdlo0K5uSfMXaiUsdnU
 4/+8Sk5kYcclR+O2git9VG0PP0l8PQi+2q0k+6WHWVltxsljhUmy9KaXAAUnlGI/9KmMp
 pv8TaADdWz1iSaQqdT77//vWeHNROwYIImbIYvmmdLEluQbv6tj9Nn83i29REW6imvaH8
 hmWD9NkKN7vg1t5qx7G3xqw6FrQS/rTSieKtKyqUcr04HULoOL9ipJxaD/X+k7+gk1AQQ
 NH0e7Ilmxf+BA43w6sD8OC06ofe8mRnEr/SLclP5Zu2Ap7xOBz6v0MXaiEidTWtiZyg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OCXWBLTM; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OCXWBLTM
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BA6C80AC4
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:10:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B55940281;
 Tue, 13 Oct 2026 09:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6876E1F000FF;
 Tue, 13 Oct 2026 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791882641;
 bh=5T42FVXX7rKbweQ2RDgwcpmfdiHoodZsDXUmc/LLalU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=OCXWBLTMp9LpwBD8R01yKnVv1UHP/H0pwQSBPG9h112Wj7wtODZBBJow03aT80DVH
 Fh2YPs8DG030mprTMpwK6Pj5lWAXtAiWcDS6hjt5mh/YuNDu8GNekHxHLwHjXwk4+8
 LT97om78IR6a7xMpe0LE0USy+Lkulnby+oQ30yCMlYDTXNGsxQNOFENIOqInZuPnsl
 momAPQua5EK5PNQ897m4tFpviw9Iqi/KgM+L/NPCxFhw09f7ai1r+Mj0B7rVTDS4OS
 3qNipqfI2qwqfl9a/k0CKOFqr3GLnSdfwN1SLe70xEYCRhbC21m3U17SWeDfdKqswI
 5CUGQxP+NdtrQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Shahriyar
 Jalayeri <shahriyar@byteray.co.uk>, Quentin Schulz
 <quentin.schulz@cherry.de>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 4/5] fastboot: add flashing lock/unlock/get_unlock_ability
In-Reply-To: <CAPzfCAYiLy0n36mp9Fui3ycrvXxJKtuhLPAKgxrh=KhYniPq4A@mail.gmail.com>
References: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
 <20261011-upstream-avb_lock_unlock_b4-v1-4-a45aeca54016@oss.qualcomm.com>
 <CAPzfCAYiLy0n36mp9Fui3ycrvXxJKtuhLPAKgxrh=KhYniPq4A@mail.gmail.com>
Date: Tue, 13 Oct 2026 11:10:39 +0200
Message-ID: <xhkdb4ieq7ypc.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Igor,

On Mon, Oct 12, 2026 at 20:23, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>=
 wrote:

> Hi Mattijs,
>
> On Sun, Oct 11, 2026 at 4:42=E2=80=AFPM Igor Opaniuk
> <igor.opaniuk@oss.qualcomm.com> wrote:
>>
>> Android's fastboot client changes the device lock state with
>> "fastboot flashing lock|unlock" and asks "flashing get_unlock_ability"
>> first. U-Boot has the state in the AVB TA (avb_write_lock_state(), used =
by
>> the "avb lock/unlock" shell commands) but no fastboot front end for it, =
so
>> a device could only be unlocked from the serial console.
>>
>> Add the three commands and the "unlocked" variable behind
>> CONFIG_FASTBOOT_CMD_FLASHING. As AVB requires, both transitions erase
>> userdata (and metadata, which holds the file based encryption keys) befo=
re
>> the state changes and are refused when userdata cannot be erased; the TA
>> resets the rollback indexes on a state change. get_unlock_ability always
>> reports 1 since U-Boot does not evaluate the "OEM unlocking" setting
>> Android keeps in the frp partition.
>>
>> Tested on QEMU virt with OP-TEE over "fastboot tcp": unlock and lock
>> erase the partitions and flip the state reported by getvar unlocked and
>> "avb is_unlocked".
>>
>
> This exact patch ("avb: device lock state, root key provisioning and
> in-place verification")
> fails to compile in every configuration that has fastboot but not
> FASTBOOT_CMD_FLASHING.
> The extended CI job run just caught that. I=E2=80=99ll address it in v2.

Thanks for the notice. I'll look at v2.

Mattijs

