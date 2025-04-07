Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEADC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 925838306D;
	Mon,  7 Apr 2025 20:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="f3B8sus1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E7282EAA; Mon,  7 Apr 2025 19:41:38 +0200 (CEST)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C47E182E76
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 2DEF7447C6;
 Mon,  7 Apr 2025 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1744047694; bh=XNFTgFkTRxNmid5TGfqQC5UOWxcXzJOGOBCGeSEy1Z8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=f3B8sus1f+LVnKO0q+rUb+u3JsBqmkjsndxpppdgJj3oNkGMaIwBoByR6sBI8omUA
 KzBVxi2/9g1VsmSxZh7YKctGa90Q1ujctQ4QHS87Sb1DAXMI0AYEkXUETkhuxhtxbj
 I2SzMSr4owOmJD2M5YQRIppqdtXpiiyUMMxkfcMa5U6RBdmqoDJQ3cNHKoRXeYl1zE
 nl/HizioXHFK6VIuj5WuX/gm/VMkLK8DD7y60GMVn4l5SentB6FbTNfm5X4uA5fPcA
 e9VLGNqMDG8g9wmb/Iz0kEaeEPqNU+cZ83GFtzwogbF2Kb5m4gwXEBmtrdBvedfiv2
 gUt2G5P24M3lg==
Message-ID: <29de8d67-ca58-4ac5-8912-1491feb01de4@marcan.st>
Date: Tue, 8 Apr 2025 02:41:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] USB xHCI wrong act_len calculation in case of
 using multipe TRB
To: bigunclemax@gmail.com
Cc: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Godfrey Mwangi <godmwan@microsoft.com>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20250321165853.742837-1-bigunclemax@gmail.com>
Content-Language: en-US
From: marcan <marcan@marcan.st>
In-Reply-To: <20250321165853.742837-1-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 07 Apr 2025 20:15:10 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 2025/03/22 1:58, bigunclemax@gmail.com wrote:
> From: Maksim Kiselev <bigunclemax@gmail.com>
> 
> Hello everyone!
> 
> I've encountered an issue where the actual length of received data is
> calculated incorrectly in the case of a multiple TRB request.
> 
> Below, I'll try to describe the essence of the problem:
> 
> A USB-ethernet adapter ASIX ax88179 is connected to my board Li4pi,
> and I'm sending a DHCP request to the server via dhpc command.
> 
> The response from the DHCP server always has the same length (0x168).
> However, in some cases, I noticed that the received response had
> an incorrect length and network subsystem is completely ingnore
> incoming packets.
> 
> The problem turned out to be in the xhci_bulk_tx() function.
> I added some debugging[1] to better understand what's happening.
> 
> Here's the log from a working case:
> ```
>      dev=000000057f786b90, pipe=c0010283, buffer=000000057f787540, length=20480
>      PUSH. trb_len: 0x5000
>      POP. trb_len: 0x4e98, comp_code: 0xd
>      udev->act_len: 0x168
> ```
> 
> And here's the log from a non-working case:
> ```
>      dev=000000057f78b610, pipe=c0010283, buffer=000000057f78bfc0, length=20480
>      PUSH. trb_len: 0x4040
>      PUSH. trb_len: 0xfc0
>      POP. trb_len: 0x3ed8, comp_code: 0xd
>      POP. trb_len: 0x0, comp_code: 0x1
>      udev->act_len: 0x1128

This looks like a bug in your host controller. Completion code 0xd is 
"short packet", which is as expected. However, completion code 0x1 is 
"success", which is unexpected. According to xHCI 4.10.1.1.2:

> If the Short Packet occurred while processing a Transfer TRB with only an ISP
> flag set, then two events shall be generated for the transfer; one for the Transfer
> TRB that the Short Packet occurred on, and a second for the last TRB with the
> IOC flag set. Table 6-38 defines the Completion Code and TRB Transfer Length
> for the first event. In the second event, the Completion Code shall be set to
> Short Packet, and the TRB Transfer Length should be set to the same value that
> was reported by the initial Short Packet Event.

So the second event should have had completion code 0xd too.

What host controller is this? Though this is kind of irrelevant, because 
the correct fix would ignore this quirk anyway (see below)

> ```
> As you can see, in the second case, the buffer spans a 64KB boundary
> (buffer=000000057f78bfc0 + 0x5000).
> Therefore, it is split into two TRBs with lengths 0x4040 and 0xfc0.
> 
> Then, act_len is calculated as the difference between length and
> trans_event.transfer_len:
> ```
> 0x5000 - 0x3ed8 = 0x1128
> ```
> 
> However, it seems that this is not entirely correct,
> and act_len should be calculated as:
> 
> ```
> trb_buff_len - trans_event.transfer_len
> (0x4040 - 0x3ed8 = 0x168)
> ```
> 
> 0x168 is the correct length, which is the same as the length
> obtained in the first case where network rx works fine.
> 
> Also I looked at the Linux xhci-ring code where urb->actual_length
> calculated as:
> [2]
> ```
>      requested = td->urb->transfer_buffer_length;
>      remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
> ```
> [3]
> ```
>      td->urb->actual_length = requested - remaining;
> ```
> 
> Perhaps I missed something or misunderstood, so I would appreciate any help.

You're looking at the control transfer path. This is the bulk path:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/host/xhci-ring.c?h=v6.14-rc7#n2604

There you can see there are two branches. If the event happened on the 
last TRB, just subtract the remaining bytes from the total transfer 
size. If the event happened earlier (short packet with completely 
untransferred TRBs remaining), then you need to add up the TRB lengths 
up to and including the current TRB, and subtract the event remaining 
bytes from *that* (excluding any subsequent TRBs). This both fixes your 
issue and ignores the apparent bug in your host controller (since you're 
supposed to do all this processing when the short TRB is processed and 
completely ignore the second event on the last TRB).

So your patch is incorrect, it fixes the specific case you are hitting 
but breaks other split TRB cases. A more complex patch is needed that 
does this:

- In the if branch (short packet in non final TRB case, first event):
-- Add up the TRB lengths up to and including the event's associated TRB
-- Call record_transfer_result() passing that partial sum as length 
(instead of available_length) and the current event (first of the two)
-- Set a flag
- Later, before returning from the function, check the flag and do NOT 
call record_transfer_result() again on the final event, since the length 
was already calculated earlier and the length field of the final event 
is not useful (it is either wrong as in your case, or per spec a repeat 
of the short TRB's length field, but this information is useless without 
the TRB index that was short, which is not the final TRB).

> 
> ---
> 
> [1] Patch for debug output
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 89d2e54f20a..b1433a16a99 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -791,6 +791,8 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
>                  trb_fields[2] = length_field;
>                  trb_fields[3] = field | TRB_TYPE(TRB_NORMAL);
>   
> +               debug("PUSH. trb_len: 0x%x\n", trb_buff_len);
> +
>                  last_transfer_trb_addr = queue_trb(ctrl, ring, (num_trbs > 1), trb_fields);
>   
>                  --num_trbs;
> @@ -816,6 +818,10 @@ again:
>                  return -ETIMEDOUT;
>          }
>   
> +       debug("POP. trb_len: 0x%x, comp_code: 0x%x\n",
> +             (int)EVENT_TRB_LEN(le32_to_cpu(event->trans_event.transfer_len)),
> +             GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len)));
> +
>          if ((uintptr_t)(le64_to_cpu(event->trans_event.buffer)) !=
>              (uintptr_t)last_transfer_trb_addr) {
>                  available_length -=
> @@ -831,6 +837,7 @@ again:
>          available_length -= first_trb_trimmed_sz;
>   
>          record_transfer_result(udev, event, available_length);
> +       debug("udev->act_len: 0x%x\n", udev->act_len);
>          xhci_acknowledge_event(ctrl);
>          xhci_inval_cache((uintptr_t)buffer, length);
>          xhci_dma_unmap(ctrl, buf_64, length);
> 
> 
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/host/xhci-ring.c?h=v6.14-rc7#n2346
> [3] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/host/xhci-ring.c?h=v6.14-rc7#n2413
> 
> Maksim Kiselev (1):
>    usb: xhci: fix calculation of act_len in case of using multipe TRB
> 
>   drivers/usb/host/xhci-ring.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 

