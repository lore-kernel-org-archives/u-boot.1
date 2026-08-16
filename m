Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D42C5DF6D
	for <u-boot@archiver.kernel.org>; Sun, 16 Aug 2026 17:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D38FD60606;
	Sun, 16 Aug 2026 17:41:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQrt9xVHz0Y8; Sun, 16 Aug 2026 17:41:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01E1460615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786902085;
	bh=OouZnqtWLN392ZXy0dWjGUa0Y71HitU+N6QOpi8QraE=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z9gFmUzZxPMFdAIa9WgJqC/YGKwJICo1UJyuVMb/LtteAFnZHQ6qFUZXHGotTIg/Y
	 eKlcor9hixrrjFVls2V0LTQ+Iqs7c5pNBOT9NaPoaC/SNjfF89oCT8hkVexuWEg1ye
	 oX330oM7oC3jz4AKIpze3XZA0pXV3pHAVIBKG/sCpORrxqp+vhuu7g75GhpMLKbWi4
	 V+/EoGFQ0edFXyL5o0Wk0ToCHGyZ/Oox3Qpq0bvWjS6N4uKhQUxfIbkR7lzcZlB9Di
	 S9x9uWv4MbSrEmIN8gObhTqr+pWvLYumsLzkbOsno6Ex8WUQml5lw7jjksSVmuA3is
	 lV1Ok3efiFqnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01E1460615;
	Sun, 16 Aug 2026 17:41:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 781B723F
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 17:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A179406D5
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 17:41:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T7oA_f9T2wag for <u-boot@lists.u-boot-project.org>;
 Sun, 16 Aug 2026 17:41:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::6a; helo=mta0.migadu.com;
 envelope-from=funderscore@postmarketos.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 18A86406CF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18A86406CF
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=MzGEOej9
Received: from mta0.migadu.com (out-106.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::6a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18A86406CF
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 17:41:19 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=OouZnqtWLN392ZXy0dWjGUa0Y71HitU+N6QOpi8QraE=; 
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786902077; v=1; x=1787506877;
 b=MzGEOej9ortdJD8GruzCHMmLcSkABtCvoNvKo0Ugahk0EttMowBUF4lNU9qSJRTEC71gRyyx
 Vg7JyXQdvZ+h1NbI/BCrpR3QNjzQnJSZU1Adu8AzS5Qdj43+qwA77A286CLxD7LXhh/wRtk3n2C
 r9+KmNziLK6hMnuCJjy1t2zjZb7EHjwBRaEkcbcX6dgzf2zYp40kSv7cimRiCSsdoqRy0ifUdvM
 QUO+20Y9foRsN26o/pKhBbWsoJlTep5TSBdT+RzxkoAHklpELjiGdOxH/PZZsfhU3CqxNvs3OwA
 +GmDT81Hd9usB16NmttTR8rE/O1u3NAI2YJV9OwUahCuw==
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
 by smtp.migadu.com with ESMTPS id 04c5a10196b62a0a;
 Sun, 16 Aug 2026 17:41:17 +0000
X-Migadu-Flow: FLOW_OUT
MIME-Version: 1.0
Date: Sun, 16 Aug 2026 17:41:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Message-ID: <d7a85b8f6f65f7caabb45ebaff5380335030bb2f@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH 1/4] serial: meson: add Amlogic S4 UART support
To: "Lucas Tanure" <tanure@linux.com>, u-boot-amlogic@groups.io,
 u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org
In-Reply-To: <e8d19994-1236-4984-be2a-058cc317d10b@linux.com>
References: <20260806101809.72526-1-tanure@linux.com>
 <20260806101809.72526-2-tanure@linux.com>
 <tjk4ry.249pxi1g19ygb@postmarketos.org>
 <e8d19994-1236-4984-be2a-058cc317d10b@linux.com>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

(didn't mean for this to be off-list sorry about that)

On Sun, 16 Aug 2026 10:42, Lucas Tanure <tanure@linux.com mailto:tanure@l=
=3D
inux.com > wrote:
>On 10/08/2026 15:01, Ferass El Hafidi wrote:
>> On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io"=3DC2=3DA0
>> <tanure=3D3Dlinux.com@groups.io mailto:linux.com@groups.io > wrote:
>>> The S4-generation UART (S4, T7, ...) derives its baud rate from the
>>> 24 MHz crystal divided by 2, selected via the XTAL_DIV2 bit in the
>>> baud rate register, while older SoCs divide the crystal by 3. Add the
>>> "amlogic,meson-s4-uart" compatible with driver data selecting the
>>> div-by-2 scheme, matching the Linux driver (meson_s4_uart_data) and
>>> the configuration the vendor BL2 programs on T7 hardware.
>>>
>>> Older SoCs keep the existing div-by-3 behaviour: Linux also uses
>>> div-by-2 on G12A, but both modes work there and switching would risk
>>> regressing boards that have shipped with div-by-3 for years.
>>>
>>> Also drain the transmitter before changing the baud rate so in-flight
>>> characters are not garbled, as the Linux driver does.
>>>
>>> Assisted-by: Claude:claude-fable-5
>>=3DC2=3DA0
>> As I understand it, LLM-assisted patches are not welcome in U-Boot rig=
=3D
ht
>> now: https://lore.kernel.org/u-boot/20260515220758.GM1858239@bill-the-=
=3D
cat/
>>=3DC2=3DA0
>> AFAIK there isn't an official AI policy yet, but it seems the concensu=
=3D
s
>> on that matter is currently "please don't". Sorry.
>
>Ok, I will drop this line.
>

Please do not drop this line. I appreciate the transparency towards your
use of AI. I would wait for someone more knowlegable about AI use
discussions to reply.

Best regards,
Ferass
